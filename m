Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291675AbSBAK3j>; Fri, 1 Feb 2002 05:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291673AbSBAK3e>; Fri, 1 Feb 2002 05:29:34 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:35858 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S291678AbSBAK3H>;
	Fri, 1 Feb 2002 05:29:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Fri, 01 Feb 2002 11:07:42 BST."
             <200202011007.g11A7hsc008080@tigger.cs.uni-dortmund.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 21:28:52 +1100
Message-ID: <9496.1012559332@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Feb 2002 11:07:42 +0100, 
Horst von Brand <brand@jupiter.cs.uni-dortmund.de> wrote:
>"David S. Miller" <davem@redhat.com> said:
>> However this isn't a driver, the crc library stuff is more akin to
>> "strlen()".  Are you suggesting to provide a CONFIG_STRINGOPS=n
>> too?  I wish you luck building that kernel :-)
>
>libc.a was invented precisely to handle such stuff automatically when
>linking... if it doesn't work, it should be fixed. I.e., making .a --> .o
>is a step in the wrong direction IMVHO.

There are two contradictory requirements.  crc32.o must only be linked
if anything in the kernel needs it, linker puts crc32.o after the code
that uses it.  crc32.o must be linked before anything that uses it so
the crc32 __init code can initialize first.

