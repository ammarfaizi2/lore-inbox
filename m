Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTDRON1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTDRON1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:13:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:26058 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S263049AbTDRON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:13:26 -0400
Date: Fri, 18 Apr 2003 09:25:21 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ISDN massive packet drops while DVD burn/verify
In-Reply-To: <20030416151221.71d099ba.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Stephan von Krawczynski wrote:

> I just experienced a massive ISDN problem while writing DVDs.
> It looks like bigger IP packets (bigger than normal ICMP ping)
> get simply dropped most of the time.
> I think the packets get lost because some allocation continously fails and disk
> i/o is faster in re-gaining the mem, but I am not quite sure. Could as well be
> ide-scsi is partially busy-looping the box to death.
> As soon as DVD writing is stopped everything comes back to normal.
> Reading DVDs does not show the problem btw.
> ping -s 1500 a.b.c.d shows about 5 packets, then stops.

My best guess would be that IDE blocks IRQs for too long and hisax 
interrupts get lost. You could try whether hdparm -u1 helps, and a 
debugging log from the hisax driver may confirm over/underruns.

--Kai



