Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUAKUsH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUAKUsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:48:07 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:10153 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265981AbUAKUsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:48:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 Jan 2004 12:47:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Martin Schlemmer <azarah@nosferatu.za.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
In-Reply-To: <1073846854.9096.133.camel@nosferatu.lan>
Message-ID: <Pine.LNX.4.44.0401111242250.20018-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Martin Schlemmer wrote:

> On Sun, 2004-01-11 at 20:42, Davide Libenzi wrote:
> > On Sun, 11 Jan 2004, Martin Schlemmer wrote:
> > 
> > > azarah@nosferatu tar $ as << EOF
> > > > PG=0xC0000000
> > > > VM=(128 << 20)
> > > > .long (-PG -VM)
> > > > .long (~PG + 1 - VM)
> > > > EOF
> > > {standard input}: Assembler messages:
> > > {standard input}:3: Warning: value 0x38000000 truncated to 0x38000000
> > > {standard input}:4: Warning: value 0x38000000 truncated to 0x38000000
> > > azarah@nosferatu tar $ objdump -D a.out
> > >  
> > > a.out:     file format elf32-i386
> > >  
> > > Disassembly of section .text:
> > >  
> > > 00000000 <.text>:
> > >    0:   00 00                   add    %al,(%eax)
> > >    2:   00 38                   add    %bh,(%eax)
> > >    4:   00 00                   add    %al,(%eax)
> > >    6:   00 38                   add    %bh,(%eax)
> > > azarah@nosferatu tar $
> > 
> > This is weird. I also verified the above with:
> > 
> > GNU assembler 2.13.90.0.18 20030206
> > 
> > and it works fine too.
> > 
> 
> What distro?  Might be an in-house patch ...

The 2.13.90.0.18 is std RH9, while 2.14 is self built.
Tested also with FC1:

GNU assembler 2.14.90.0.6 20030820

that is fine too.



- Davide


