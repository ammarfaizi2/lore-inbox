Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbULaP4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbULaP4h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbULaP4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:56:37 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:55531 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262116AbULaP4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:56:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 31 Dec 2004 07:56:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jesse Allen <the3dfxdude@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <53046857041231074248b111d5@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <1104401393.5128.24.camel@gamecube.scs.ch>  <1104411980.3073.6.camel@littlegreen>
  <200412311413.16313.sailer@scs.ch>  <1104499860.3594.5.camel@littlegreen>
 <53046857041231074248b111d5@mail.gmail.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004, Jesse Allen wrote:

> Davide Libenzi wrote:
> > I don't think that the Wine problem resolution is due to the POPF 
> > instruction handling. Basically Linus patch does a nice cleanup plus POPF 
> > handling, so maybe the patch can be split.
> 
> If you or Andi or anyone else wants to split up the patch and have me
> test it, I'd be willing.  I could try it myself if you want, though it
> will be later, as I have to leave soon.  But I really do think that it
> does have to do with POPF, since that alone seems to make wine happier
> all-round.

I don't think Linus ever posted a POPF-only patch. Try to comment those 
lines in his POPF patch ...

       if (is_at_popf(child, regs))
               return;


- Davide

