Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUDNPLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbUDNPLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:11:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:38077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264247AbUDNPLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:11:01 -0400
Date: Wed, 14 Apr 2004 08:05:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: jgarzik@pobox.com, thockin@hockin.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-Id: <20040414080505.319dc14c.rddunlap@osdl.org>
In-Reply-To: <407D3D46.9010403@nortelnetworks.com>
References: <407CEB91.1080503@pobox.com>
	<20040414005832.083de325.akpm@osdl.org>
	<20040414010240.0e9f4115.akpm@osdl.org>
	<407CF201.408@pobox.com>
	<20040414082716.GA25439@hockin.org>
	<407CFAD7.4070606@pobox.com>
	<407D3D46.9010403@nortelnetworks.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 09:31:50 -0400 Chris Friesen wrote:

| Jeff Garzik wrote:
| > Tim Hockin wrote:
| > 
| >> Somewhat off the original topic, but am I the only one who finds it weird
| >> (and error-prone) that you have to add the same KConfig to a dozen or 
| >> more
| >> Kconfig files?
| >>
| >> Shouldn't there be a KConfig libe, and all you need to do for the arch is
| >> reference the CONFIG_FOO from the lib?  Would at least save all the
| >> duplicate strings and definitions...
| 
| > Seems a lot easier just to gather the common definitions into a Kconfig 
| > file, and include it via the standard 'source' directive.
| 
| Either way, I personally would be extremely grateful for some kind of 
| standard way to add a new configurable generic feature to every 
| architecture.  I'm tired of having to add it manually.  I hadn't 
| realized about the "source" feature--seems like we should be able to 
| pull a lot of stuff into something like that even now.
| 
| On a side note, why is there no Kconfig for the "kernel" directory?

Use init/Kconfig for that.

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
