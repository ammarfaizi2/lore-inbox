Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTDXUHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTDXUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:07:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12680 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263833AbTDXUHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:07:20 -0400
Date: Thu, 24 Apr 2003 21:19:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Timothy Miller <miller@techsource.com>,
       Daniel Phillips <phillips@arcor.de>, John Bradford <john@grabjohn.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424201920.GB30082@mail.jlokier.co.uk>
References: <3EA83BBA.5060502@techsource.com> <Pine.LNX.4.44.0304241219550.22144-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304241219550.22144-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > For their smaller devices, Xilinx has a free "WebPack" which is a 
> > complete Verilog synthesizer (I don't know if it does VHDL), as well as 
> > place & route, of course.  I think it'll do up to Virtex II 250.  It 
> > also tends use fewer gates for a given design than the version of 
> > Leonardo Spectrum we have.  It just doesn't have a simulator, which is 
> > vital to any good development process.  Also, the Web Pack only runs 
> > under Windows.  Maybe it'll work with WINE?
> 
> It does work with wine - but it's sad how horrible the command line tools
> are (they were apparently first done under UNIX, and then ported to 
> Windows, and they got the Windows command line interface and trying to use 
> them in a sane way with Wine is not exactly much fun).
> 
> But yes, with Wine and a few scripts you can actually make the tools 
> usable under Linux - I tried them out and had a small silly "pong" game 
> running on one of those things (a 100k device on one of the cheap 
> development boards).

The dongled tools don't work under Wine.  Thankfully they are rarer
nowadays.  Because of a dongle, I had to write a server which ran on
Windows and accepted FPGA compilation commands, so I could invoke a
client from a Makefile on a Linux box.

What is really shitty is that you can't make the FPGA compilers do
anything fundamentally new and better.  Such as taking full advantage
of the FPGA's architecture in ways that the manufacturer hasn't
considered.

You have the equivalent of a closed source compiler & linker.  But you
don't get access to the "assembler" level so if you want to design a
new language and compile that, you must target a language that the
FPGA synthesis tool accepts.  I.e. you don't get to tweak the
placement of wires & logic in enough interesting ways.  Unfortunately,
that makes a big different to performance on an FPGA, because the
"wires" are generally slower than the logic blocks.

(That said, it is no more secret than the Pentium's microcode or
Transmeta's VLIW code.  FPGA tweaking has much more potential, though, IMHO).

> I have to admit that I would hate to actually use those tools for any real 
> work, though. 

The last tool vendor I spoke too wanted US$100,000 for their tool.
I declined.

I've heard you get a more satisfying engineering experience from the
$100,000 tools.  From a vendor, though :)

-- Jamie

