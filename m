Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTDXA7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTDXA7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:59:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56966 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264358AbTDXA7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:59:39 -0400
Date: Thu, 24 Apr 2003 02:11:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424011137.GA27195@mail.jlokier.co.uk>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423214332.H3557@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> >    A standard audio module option "volume=X" meaning "set volume X%
> >    when the module initialises".
> 
> I don't quite see how this would make user space any less
> fancy:
> 
> # insmod audio_driver volume=`retrieve_volume`
> 
> versus
> 
> # insmod audio_driver
> # aumix -L >/dev/null

Eh?  I was suggesting that the _default_ just work as quite a few
people expect:

	$ insmod audio_driver

In fact, forget about "volume".  Just have a "silent" parameter that
defaults to 0, and determines whether the device starts silent or
loads preset defaults.  Make it a core audio thing rather than a
per-driver thing, too.  "silent=1" in /etc/modules.conf self-evidently
answers the FAQ, too :)

-- Jamie
