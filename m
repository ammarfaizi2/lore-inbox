Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270485AbTGSC7C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270486AbTGSC7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:59:02 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:12808 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270485AbTGSC7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:59:00 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: More 2.6.0-test1-ac2 issues / nvidia kernel module
Date: Sat, 19 Jul 2003 04:13:54 +0100
User-Agent: KMail/1.5.2
References: <20030718154918.GA27176@charite.de>
In-Reply-To: <20030718154918.GA27176@charite.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307190413.56193.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 Jul 2003 16:49, Ralf Hildebrandt wrote:
> Yes, please: nvidia taints the kernel - so flame at your will - but
> this is a more general question regarding module loading:
>
> If I load the nvidia kernel module like this:
>
> % modprobe nvidia NVreg_Mobile=2  NVreg_SoftEDIDs=0
>
> and start kdm afterwards, it works as in 2.4 -- I get a two screen
> setup with one screen on my laptop TFT and one on my external TFT
> screen.
>
> If I use this /etc/modules.conf:

And that's the problem.  The new modprobe uses /etc/modprobe.conf rather than 
/etc/modules.conf.  In Debian you now need to put the component files into 
/etc/modprobe.d instead of /etc/modutils.  However the syntax appears to be 
mostly the same so the configuration files you already have should still 
work.

-- 
Ian.

