Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVH3WYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVH3WYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVH3WYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:24:07 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:36246 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751301AbVH3WYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:24:06 -0400
Message-ID: <4314DD2E.7060901@t-online.de>
Date: Wed, 31 Aug 2005 00:26:54 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508302039160.3743@scrub.home>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: rXRIAEZH8eMNLHV3stpfEmVi-ixSG2y4oyvUzLBCpmB1nJONubzEkL@t-dialin.net
X-TOI-MSGID: 8a9483fe-6e5a-42ed-98ea-eaabf8ed3f36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

>Could you try the patch below, for a few extra cycles you might want to 
>make it an inline function.
>  
>
No, it does not help. If there is any difference, it is too small to be 
measured on
my system ... and my system does run at 1000 Hz.

After 2.6.12 fb_pad_aligned_buffer() was changed to use memcpy() instead 
of a
bytewise copy. That slowed things down a lot, some weeks ago that was 
reverted.
fb_pad_aligned _buffer() isn´t that slow, it´s just an external function 
to be called
and that means a lot of unnecessary code.

How could I make it an inline function? It is used in console/bitblit.c, 
nvidia/nvidia.c,
riva/fbdev.c and softcursor.c.

cu,
 Knut
