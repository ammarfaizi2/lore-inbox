Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRC0OYY>; Tue, 27 Mar 2001 09:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131318AbRC0OYO>; Tue, 27 Mar 2001 09:24:14 -0500
Received: from [64.64.109.142] ([64.64.109.142]:31241 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131316AbRC0OYC>; Tue, 27 Mar 2001 09:24:02 -0500
Message-ID: <3AC0A21B.438EFE02@didntduck.org>
Date: Tue, 27 Mar 2001 09:22:19 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: ebuddington@wesleyan.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 386 'ls' gets SIGILL iff /proc is mounted
In-Reply-To: <20010327012709.I59@sparrow.nad.adelphia.net> <3AC09F14.53D06AC7@didntduck.org> <20010327091205.B80@sparrow.nad.adelphia.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington wrote:
> 
> On Tue, Mar 27, 2001 at 09:09:24AM -0500, Brian Gerst wrote:
> > >
> > > The problems are varied enough that I suspect bad hardware, but would
> > > flaky RAM cause such similar failures repeatedly? And is there a way
> > > to test RAM explicitly?
> > >
> > > Any tips appreciated, either to me (ebuddington@wesleyan.edu) or to
> > > the list.
> >
> > Silly question, but is math emulation enabled?
> 
> Yes. I should have mentioned that in the original, since it occurred
> to me also.
> 
> -Eric

Try running ls under gdb and find out what instruction is causing SIGILL
(illegal opcode).  It is possible that it was compiled to use
instructions available only on later processors, or it could potentially
be a bug in the math emulation code.

--

				Brian Gerst
