Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUFOQTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUFOQTq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUFOQTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:19:46 -0400
Received: from ned.cc.purdue.edu ([128.210.189.24]:43649 "EHLO
	ned.cc.purdue.edu") by vger.kernel.org with ESMTP id S265740AbUFOQTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:19:39 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Compile problems on alpha: 2.6.6, 2.6.7-rc2
Date: Tue, 15 Jun 2004 11:19:36 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200406151100.25284.pat@computer-refuge.org> <20040615160709.GY1444@holomorphy.com>
In-Reply-To: <20040615160709.GY1444@holomorphy.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YGyzAdlEg1I+iyq"
Message-Id: <200406151119.36333.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YGyzAdlEg1I+iyq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 15 June 2004 11:07, William Lee Irwin III wrote:
> On Tue, Jun 15, 2004 at 11:00:25AM -0500, Patrick Finnegan wrote:
> > I'm not quite sure what's causing this, but I get the following
> > error message (make V=1):
> >         ld  -static -N  -T arch/alpha/kernel/vmlinux.lds.s
> > arch/alpha/kernel/head.o   init/built-in.o --start-group 
> > usr/built-in.o arch/alpha/kernel/built-in.o 
> > arch/alpha/mm/built-in.o
> > arch/alpha/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o
> > fs/built-in.o  ipc/built-in.o  security/built-in.o 
> > crypto/built-in.o lib/lib.a  arch/alpha/lib/lib.a  lib/built-in.o
> > arch/alpha/lib/built-in.o  drivers/built-in.o  sound/built-in.o
> > net/built-in.o --end-group  -o .tmp_vmlinux1
> > local symbol 0: discarded in section `.exit.text' from
> > drivers/built-in.o make then aborts at this step.  At other times,
> > I've gotten errors that read the same as the above line, for
> > symbols "1" through "4", in order. I'm going to guess there's a
> > problem with one of the drivers I've got built-in to the kernel,
> > but I haven't been able to figure much else out..
>
> Could you try to locate it with scripts/reference_discard.pl, and if
> that fail, post your .config (preferably compressed) so I can try to
> debug this on my alphas?

Here:

Finding objects, 1285 objects, ignoring 386 module(s)
Finding conglomerates, ignoring 61 conglomerate(s)
Scanning objects
Error: ./drivers/serial/8250_pnp.o .data refers to 0000000000000020 
REFQUAD           .exit.text
Done

So, is this an ISAPNP thing?  My .config is attached (compressed).  I 
turned off ISAPNP and am running make on it again right now.

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org

--Boundary-00=_YGyzAdlEg1I+iyq
Content-Type: application/x-gzip;
  name="alpha-2.6.6-config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="alpha-2.6.6-config.gz"

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

--Boundary-00=_YGyzAdlEg1I+iyq--
