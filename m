Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287705AbSAFE0s>; Sat, 5 Jan 2002 23:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287711AbSAFE0j>; Sat, 5 Jan 2002 23:26:39 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:53927 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287705AbSAFE0W>;
	Sat, 5 Jan 2002 23:26:22 -0500
From: dewar@gnat.com
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020106042617.E64B0F28BD@nile.gnat.com>
Date: Sat,  5 Jan 2002 23:26:17 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<There are some C compilers that are useful for implementing a kernel,
that's true.  But when the maintainers of such a compiler say things
that imply that they feel they are constrained only by the standard
and not by the needs of their users, it is very discouraging.
>>

What is important is for these users to *clearly* and at least 
semi-formally, state their needs. Saying general things about the need
to be useful is hardly helpful!

You quote Florian:

> You cannot manipulate machine addresses in C because C is
> defined as a high-level language, without backdoors to such low-level
> concepts as machine addresses.

Unfortunately Florian is right. The ability in C to manipulate low-level
concepts such as machine addresses is NOT part of the language, but rather
comes from exploiting aspects that are deliberately left implementation
dependent. This is why it is so important to formally state the requirements
that are being depended on.

I don't think anyone seriously objects to trying to formulate solutions
to what is indeed a very important problem.

But it is hardly helpful for people to take the attitude "we wrote this
kernel, and it worked, and any change to the compiler that stops it from
working is unacceptable".
