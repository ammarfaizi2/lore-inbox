Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVAMWxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVAMWxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVAMWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:49:48 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:23550 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261814AbVAMWst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:48:49 -0500
Date: Thu, 13 Jan 2005 14:46:01 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: "Allan B. Cruse" <cruse@cs.usfca.edu>
Cc: binutils@sources.redhat.com, gcc@gcc.gnu.org,
       libc-alpha@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Change i386 assembler/disassembler for SIB with INDEX==4
Message-ID: <20050113224601.GA3184@lucon.org>
References: <20050113203328.1174721A3F@nexus.cs.usfca.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113203328.1174721A3F@nexus.cs.usfca.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 12:33:28PM -0800, Allan B. Cruse wrote:
> 
> On Thu, 13 Jan 2005, "H. J. Lu" <hjl@lucon.org> wrote:
> >
> >
> >
> > Subject: Change i386 assembler/disassembler for SIB with INDEX==4
> > 
> > I am proposing to change i386 assembler/disassembler for SIB with
> > INDEX==4
> >                                                                                
> > http://sources.redhat.com/bugzilla/show_bug.cgi?id=658
> >                                                                                
> > It will change the assembler output for (%ebx,[1248]). I am not too
> > worried about the disassembler output since assembler can't generate
> > SIB with INDEX==4 directly today. Any comments?
> > 
> > 
> > H.J.
> > 
> 
> 
> This change would give programmers the freedom to write instruction-
> syntax that the processor cannot actually execute, is that right?  

No. Assemberl will turn "mov (%ebx,2),%eax" into "8b 04 63", which
is valid i386 machine code.

> 
> Perhaps the downside to this would lie in the hours of debugging and
> private research each programmer would then be faced with, trying to
> figure out why  " movl (%esi,2),%eax "  wasn't doing what he/she had
> intended, and which the assembler had dutifully accepted.    --ABC
> 

What do you expect "movl (%esi,2),%eax" will do?


H.J.
