Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUL3B4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUL3B4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUL3B4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:56:19 -0500
Received: from 80-219-198-150.dclient.hispeed.ch ([80.219.198.150]:3968 "EHLO
	xbox.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id S261505AbUL3B4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:56:12 -0500
Subject: Re: ptrace single-stepping change breaks Wine
From: Thomas Sailer <sailer@scs.ch>
To: Jesse Allen <the3dfxdude@gmail.com>
Cc: Mike Hearn <mh@codeweavers.com>, Linus Torvalds <torvalds@osdl.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <5304685704122912132e3f7f76@mail.gmail.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <1104348944.5645.2.camel@kronenbourg.scs.ch>
	 <5304685704122912132e3f7f76@mail.gmail.com>
Content-Type: text/plain
Organization: Supercomputing Systems AG
Date: Thu, 30 Dec 2004 02:49:54 +0100
Message-Id: <1104371395.5128.2.camel@gamecube.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No joy with
linux-2.6.10
patch-2.6.10-ac1
01-ptrace-reverse.diff
sigtrap-reverse.diff

Below is the seh trace output. In the working case (2.6.8) there is no
trace:seh: output at this point.

Tom

Compiling vhdl file U:/home/sailer/src/vhdl/dvbc_pcseng/vprim.vhd in
Library synwork.
trace:seh:EXC_RtlRaiseException code=c0000005 flags=0 addr=0x770e6151
trace:seh:EXC_RtlRaiseException  info[0]=00000000
trace:seh:EXC_RtlRaiseException  info[1]=72772078
trace:seh:EXC_RtlRaiseException  eax=72772074 ebx=b7a01d9c ecx=7f7daa0c
edx=fffffffa esi=7f7499b0 edi=7f7daa0c
trace:seh:EXC_RtlRaiseException  ebp=77058a70 esp=77ad2150 cs=0073
ds=007b es=007b fs=003b gs=0033 flags=00210206
trace:seh:EXC_CallHandler calling handler at 0x77134e9f code=c0000005
flags=0
trace:seh:EXC_CallHandler handler returned 1
trace:seh:EXC_CallHandler calling handler at 0x103662d2 code=c0000005
flags=0
trace:seh:EXC_CallHandler handler returned 1
trace:seh:EXC_CallHandler calling handler at 0x1034ec8e code=c0000005
flags=0
trace:seh:EXC_CallHandler handler returned 1
trace:seh:EXC_CallHandler calling handler at 0x4024a0 code=c0000005
flags=0
trace:seh:EXC_RtlUnwind code=c0000005 flags=2
trace:seh:EXC_CallHandler calling handler at 0x77ebe2e0 code=c0000005
flags=2
trace:seh:EXC_CallHandler handler returned 1
trace:seh:EXC_CallHandler calling handler at 0x77134e9f code=c0000005
flags=2
trace:seh:EXC_CallHandler handler returned 1
trace:seh:EXC_CallHandler calling handler at 0x103662d2 code=c0000005
flags=2
trace:seh:EXC_CallHandler handler returned 1
trace:seh:EXC_CallHandler calling handler at 0x1034ec8e code=c0000005
flags=2
trace:seh:EXC_CallHandler handler returned 1
FATAL_ERROR:Xst:Portability/export/Port_Main.h:127:1.13 - This
application has discovered an exceptional condition from which it cannot
recover.  Process will terminate.  To resolve this error, please consult
the Answers Database and other online resources at
http://support.xilinx.com. If you need further assistance, please open a
Webcase by clicking on the "WebCase" link at http://support.xilinx.com



