Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSGLPH7>; Fri, 12 Jul 2002 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSGLPH6>; Fri, 12 Jul 2002 11:07:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24069 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316580AbSGLPH4>; Fri, 12 Jul 2002 11:07:56 -0400
Subject: Re: strange IP stack behavior
To: Jack.Bloch@icn.siemens.com (Bloch, Jack)
Date: Fri, 12 Jul 2002 16:34:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <180577A42806D61189D30008C7E632E879398E@boca213a.boca.ssc.siemens.com> from "Bloch, Jack" at Jul 12, 2002 10:41:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T2Qj-0003Df-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am running Red Hat 7.2 (Kernel Version 2.4.7-10) and have the following

You should update to the errata kernel firstly.

> communication is accomplished via UDP/IP. During my application
> initialization, I use the SIOCSARP IOCTL to force permanent cache entries
> for the devices that I communicate with. The problem that I see is that
> sporadically, when I want to transmit the first message to a device, the
> destination MAC address is 0. All subsequent messages contain the correct
> MAC address. 

The kernel should never try to send out a packet with an incomplete header.
That may well indicate a bug

	https://bugzilla.redhat.com/bugzilla

but please reproduce with the errata kernel first
