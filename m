Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWE1STv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWE1STv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 14:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWE1STv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 14:19:51 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:26258 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1750851AbWE1STv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 14:19:51 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
Date: Sun, 28 May 2006 19:20:02 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <44793100.50707@perkel.com> <200605281854.08371.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605281854.08371.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281920.02609.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 18:54, Alistair John Strachan wrote:
> On Sunday 28 May 2006 06:11, Marc Perkel wrote:
> > Is there a problem with the forcedeth driver not being compatible with
> > the Asus K8N-VM motherboard? I installed Fedora Core 5 and the Ethernet
> > doesn't want to work. I installed the latest FC5 kernel which is some
> > flavor og 2.6.16 and it still doesn't work. The FC4 CD and rescue disk
> > don't work either. Windows XP however does work so I know that hardware
> > is good.
> >
> > lspci says the hardware is an nVidia MCP51 ethernet controller. What am
> > I missing?
>
> A decent bug report. Please go to http://bugzilla.kernel.org/ and publish
> your lspci, /proc/interrupts and dmesg and if you're sure it's forcedeth,
> put the maintainer on CC.

Five minutes of research and I found this:

http://www.asus.com.tw/products4.aspx?modelmenu=2&model=952&l1=3&l2=14&l3=245

It indicates that the board, although using an nForce 410 chipset, does NOT 
use NVIDIA ethernet, but (quote) "Relatek RTL8201CL external PHY"; you're 
probably trying the wrong driver and this is the source of the problem.

This info could be wrong, but I thought it might help.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
