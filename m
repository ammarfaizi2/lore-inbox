Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVDBRLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVDBRLk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDBRLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 12:11:40 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:26696 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261693AbVDBRLh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 12:11:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=dfTdFpi9xkbiNAiFJZZxkoQfLbiGSIjXmig/jEFUcW0zyG4oBpHqTsg4hMuRHraW4LoSk7QqeUS+L5spYsqikdQuXoIcZy6OSGRtNtWW9LeKZexmJRGKqS0VWsTIv7fztw/Cqa/TOpSC+w084I1R3zi7AM5T8QfgHrOsrNl6Nms=
Date: Sat, 2 Apr 2005 19:11:40 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: make OOM more "user friendly"
Message-Id: <20050402191140.3de10df2.diegocg@gmail.com>
In-Reply-To: <424ECF4D.6070800@tiscali.de>
References: <20050402180545.29e10629.diegocg@gmail.com>
	<424ECF4D.6070800@tiscali.de>
X-Mailer: Sylpheed version 1.9.7+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 02 Apr 2005 18:58:53 +0200,
Matthias-Christian Ott <matthias.christian@tiscali.de> escribió:

> I disagree this is _not_ usefull. If the user don't knows what OOM means 
> he can use google to get this information.

And google will take them to what random source of information? There's no "official"
meaning of what OOM is outside the kernel.... And anyway, why shouldn't the kernel tell
what's happening? That printk is not exactly a fifty-page explanation, it just says "your
system has run out of memory" instead of "OOM", which is what it's really happening and
it's not verbose at all, and it doesn't scare users.

OOM doesn't prints just those messages, if prints a lot of "debugging info" about the state
of the memory subsystem, I've found people in usenet who reboots their systems when
they see that because they think it's a critical failure or something - and looking at how it's
printed, I don't blame them. This is the reason why I submitted this patch.

(and I'd have added a "look at Documentation/oom.txt", but there's zero documentation of
what OOM is, what are the causes of it, tips of how to find apps triggering it and tips to fix
it, and I'm not the right person to write it, so...)
