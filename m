Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUJBE5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUJBE5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 00:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUJBE5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 00:57:50 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:47751 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S267251AbUJBE5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 00:57:46 -0400
Date: Sat, 2 Oct 2004 14:57:25 +1000
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041002045725.GC1049@zip.com.au>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org> <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org> <20041001103032.GA1049@zip.com.au> <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 01, 2004 at 07:34:34AM -0700, Linus Torvalds wrote:
> > BTW. I just realised (and I apologise for not doing so earlier) that I'm
> > not using ACPI on this box.
> 
> For you, the bigger patch shouldn't have made any difference. But it's 
> needed for some other people who have BIOS'es that mark PCI regions as 
> being reserved for the motherboard, and they get resource conflicts 
> otherwise (resource conflicts that largely go away with 
> "insert_resource()", but if we want to change that to "request_resource()" 
> then that other patch is needed).

Aha.

> Can you send me your ioports from 2.6.9-rc3 _with_ the 
> "request_resource()" change..

Diff says that the file is thesame as the one without patch+change
that doesn't work.

Attached none-the-less.

-- 
    Red herrings strewn hither and yon.

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioports.2.6.9-rc3"

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:0e.0
  1000-107f : 0000:00:0e.0
1080-10bf : 0000:00:0d.0
  10a0-10af : 0000:00:14.1
    10a0-10a7 : ide0
    10a8-10af : ide1
10c0-10df : 0000:00:14.2
10f0-10f7 : 0000:00:0d.0
10f8-10ff : 0000:00:0d.0
1400-14ff : 0000:00:0f.0
  1400-14ff : tulip
1800-1803 : 0000:00:0d.0
1804-1807 : 0000:00:0d.0
f800-f83f : 0000:00:14.3
fc00-fc1f : 0000:00:14.3

--+HP7ph2BbKc20aGI--
