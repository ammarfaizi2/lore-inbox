Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUHEIfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUHEIfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267606AbUHEIfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:35:09 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50955 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267602AbUHEIfA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:35:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linus Torvalds <torvalds@osdl.org>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 11:33:55 +0300
X-Mailer: KMail [version 1.4]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thursday 05 August 2004 10:25, Linus Torvalds wrote:
> On Wed, 4 Aug 2004, Gene Heskett wrote:
> > I *thought* I had PREEMPT turned off, but when I did a make xconfig,
> > it was turned on.  So its now off, and a new 2.6.8-rc3 is building.
> > It was frame pointers I had turned on for the last build, still on for
> > this one underway now.
>
> Your latest bug report definitely had preempt on, you could see the
> preempt code in the oops output when disassembled.
>
> Also, could you please enable CONFIG_DEBUG_BUGVERBOSE by hand if you use
> the -mm tree, since you definitely hit a BUG() in there somewhere, but in
> the -mm tree, the BUG()  message is totally unreadable unless you enable
> BUGVERBOSE (and it's not in the config file).

It is not a BUG().

It's an oops (dereferencing a d_op pointer with value 0x00000900+14
IIRC, Gene has complete disassembly with location of that event).

It is not reproducible on request, but happens for him from time
to time in the same place with the same bogus value of d_op.
-- 
vda
