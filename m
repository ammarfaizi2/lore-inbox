Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWAXPGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWAXPGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWAXPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:06:05 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:49177 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964987AbWAXPGC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:06:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=dkQH4z+d86cX4N8BqPESvz18tF/Jn98Uggv6hW7MYez51BbxgZNBgWm4rPXM2yE7goxFar9GjL17XgdTC5R2O82jhqhSCeFHwsLjosGa4cBDCTKmm0fFkb2ocr7Ooq1wX4YRRhfyYY57bCannf/9BAmDEFm/E7rtz5TjaROy2o0=
Date: Tue, 24 Jan 2006 16:04:27 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: nikita@clusterfs.com, mloftis@wgops.com, barryn@pobox.com,
       a1426z@gawab.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-Id: <20060124160427.1ed68461.diegocg@gmail.com>
In-Reply-To: <728201270601240636p58fead78m781fb104c3d73da9@mail.gmail.com>
References: <200601212108.41269.a1426z@gawab.com>
	<986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	<E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	<728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
	<280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
	<17365.23510.525066.57628@gargle.gargle.HOWL>
	<728201270601240636p58fead78m781fb104c3d73da9@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 24 Jan 2006 08:36:50 -0600,
Ram Gupta <ram.gupta5@gmail.com> escribió:

> This feature is interesting though I am not sure about the fast boot
> part of OSX.
> as at boot time these applications are all started first time. So
> there were no access pattern as yet. They still have to be demand
> paged. But yes later accesses may be faster.


The stats are saved on disk (at least on windows). You don't really
care about "later accesses" when everything is already in cache,
this is supposed to speed up cold-cache startup. I don't know
if mac os x does it for every app, the darwin code I saw was
only for the startup of the system not for every app, but maybe that
part was in another module

Linux is the one desktop lacking something like this, both windows
and max os x have things like this. I've wondered for long time if
it's worth of it and if it could improve things in linux. The
prefault part is easy once you get the data. The hard part is to get
the statistics: I wonder if mincore(), /proc/$PID/maps 
and the recently posted /proc/$PID/pmap and all the statistics
the kernel can provide today are enought, or it's neccesary
something more complex.
