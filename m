Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbTAIP6J>; Thu, 9 Jan 2003 10:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267760AbTAIP6I>; Thu, 9 Jan 2003 10:58:08 -0500
Received: from mail.t-intra.de ([62.156.147.75]:3161 "EHLO mailc0910.dte2k.de")
	by vger.kernel.org with ESMTP id <S267744AbTAIP6F>;
	Thu, 9 Jan 2003 10:58:05 -0500
Date: Thu, 9 Jan 2003 19:03:38 +0100 (CET)
From: Chrissie <x.chrissie.x@t-online.de>
To: mdharm-usb@one-eyed-alien.net, <linux-kernel@vger.kernel.org>,
       <sjr@debian.org>, <eyesee@gmx.net>, <anti@webhome.de>,
       <thomas.hechelhammer@t-online.de>
Subject: Belongs to oops with mass storage
Message-ID: <Pine.LNX.4.50.0301091900590.1017-100000@balearen.x-tra-designs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2003 16:06:48.0143 (UTC) FILETIME=[1D056DF0:01C2B7F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok guys, thanks for fast response.

1.) i get the oops also, if i set the processor to 733 Mhz, i just tried
it 5 mins ago.

2.) the ksymoops message here:
(Sorry for  the last posting with hex numbers, i am not an experienced
kernel hacker...)

>>EIP; c01261d8 <kfree+2c/b0>   <=====

>>eax; 00b00000 Before first symbol
>>edx; c100001c <_end+d18240/1054e224>
>>ebp; ce13be00 <_end+de54024/1054e224>
>>esp; c9c39de0 <_end+9952004/1054e224>

Trace; c01d2b23 <usb_destroy_configuration+3f/1b4>
Trace; d0838e50 <[usb-uhci]uhci_free_dev+28/30>
Trace; c01d202c <usb_free_dev+24/3c>
Trace; d0839852 <[usb-uhci]uhci_interrupt+c6/12c>
Trace; c0107e8d <handle_IRQ_event+31/5c>
Trace; c0107ff6 <do_IRQ+6a/a8>
Trace; c010a1d8 <call_do_IRQ+5/d>
Trace; c011f09b <handle_mm_fault+7f/b0>
Trace; c010eb64 <do_page_fault+160/480>
Trace; c010ea04 <do_page_fault+0/480>
Trace; c011992c <rm_sig_from_queue+14/18>
Trace; c011a904 <do_sigaction+9c/d4>
Trace; c0106cc4 <error_code+34/3c>

Code;  c01261d8 <kfree+2c/b0>
00000000 <_EIP>:
Code;  c01261d8 <kfree+2c/b0>   <=====
   0:   2b 59 0c                  sub    0xc(%ecx),%ebx   <=====
Code;  c01261db <kfree+2f/b0>
   3:   89 d8                     mov    %ebx,%eax
Code;  c01261dd <kfree+31/b0>
   5:   31 d2                     xor    %edx,%edx
Code;  c01261df <kfree+33/b0>
   7:   f7 76 18                  divl   0x18(%esi)
Code;  c01261e2 <kfree+36/b0>
   a:   89 c3                     mov    %eax,%ebx
Code;  c01261e4 <kfree+38/b0>
   c:   86 41 14                  xchg   %al,0x14(%ecx)
Code;  c01261e7 <kfree+3b/b0>
   f:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)
Code;  c01261eb <kfree+3f/b0>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.


Chrissie
x.chrissie.x@t-online.de
