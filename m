Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVELV3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVELV3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVELV3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:29:14 -0400
Received: from smtp05.auna.com ([62.81.186.15]:37773 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262129AbVELV3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:29:01 -0400
Date: Thu, 12 May 2005 21:28:56 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Need kernel patch to compile with Intel compiler
To: linux-kernel@vger.kernel.org
References: <377362e105051207461ff85b87@mail.gmail.com>
	<Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com> (from
	linux-os@analogic.com on Thu May 12 17:35:49 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1115933336l.8448l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Thu, 12 May 2005 23:28:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.12, Richard B. Johnson wrote:
> On Thu, 12 May 2005, Tetsuji "Maverick" Rai wrote:
> 
> > In this mailing list archive I found a discussion on how to compile
> > kenrel 2.6.x with Intel C++ compiler, but it was a bit old, and only
> > kernel patch for version 2.6.5 or around so can be found.   As mine is
> > HT enabled, I want newer one.
> >
> > Does anyone know where to find it, or how to make it?
> >
> > regards,
> 
> The kernel is designed to be compiled with the GNU 'C' compler
> supplied with every distribution. It uses a lot of __asm__()
> statements and other GNU-specific constructions.
> 

The intel compiler supports all gcc syntax tweaks (__attribute__'s,
asm, cli options...) just because they want to be perfectly compatible
with gcc to compare/substitute...

> Why would you even attempt to convert the kernel sources to
> be compiled with some other tools? Also C++ won't work because
> the kernel is all about method, i.e., procedures. You need
> a procedural compiler for most of it, not an object-oriented
> one.

Intel's is a C/C++/Fortran compiler.

Last time I checked (a year or so ago) gcc catched the intel compiler
for equivalent options, or say it the other way, adjusting gcc options
you could get more or less the same performance. There were even places
where gcc generated faster code than icc. And that was gcc-3.0.x,
I think.

It is all a matter of knowing the default options that icc uses; the
big advantage (??) of icc was that it enabled the vectorizer by
default. And I think you could not allow streaming instructions
all over the kernel. I know they are used (raid) but I suppose it has
to be in a controlled way (does context switch preserve xmm registers ?).
And vector instructions are usefull just in very restricted situations.

It would be nice to redo the tests with gcc4/icc8 ;), now that gcc
has an auto-vectorizer.

In short, from my experience, I don't worry about icc. GCC is nice.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam17 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


