Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbREQSst>; Thu, 17 May 2001 14:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbREQSsl>; Thu, 17 May 2001 14:48:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261487AbREQSsa>; Thu, 17 May 2001 14:48:30 -0400
Date: Thu, 17 May 2001 14:47:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.4 failure to compile
In-Reply-To: <9e15g9$tcj$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.95.1010517144217.2854A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2001, H. Peter Anvin wrote:

> Followup to:  <3B040C80.C2A7BC6@sun.com>
> By author:    Tim Hockin <thockin@sun.com>
> In newsgroup: linux.dev.kernel
> > 
> > The aic7xxx assembler requiring libdb1 is a bungle.  Getting the headers
> > for that right on various distros is not easy.  Add to that it requires
> > YACC, when most people have bison (yes, a shell script is easy to make, but
> > not always an option). 
> > 
> 
> Most people have both.  However, if your distribution installs bison
> and not yacc and does *NOT* install the "bison as yacc" wrapper, you
> should complain to your distributor.
> 
> As far as "not always an option", that's ridiculous.  If there really
> isn't someone around who can install it globally, then put it in ~/bin
> and set your PATH.
> 
> The command "yacc" should be expected to work.  This is as insane as
> the flamage in the cdrecord documentation about Linux installing GNU
> make as "make".
> 
> 	-hpa

I have both. I also have `flex`, but not `lex'. `lex' is a simlink to
flex. What this compile wanted is some header files in expects for
`yacc` that are not present. And they don't come with the `bison`
distribution. Maybe they came with `yacc` years ago? Anyway there
are some poor assumptions being made in the source Makefile.

It would be nice to have the 'microcode' assembler running for
aic7xxx since it is now required for the thing to load.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


