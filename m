Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290643AbSAYL2v>; Fri, 25 Jan 2002 06:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290641AbSAYL2l>; Fri, 25 Jan 2002 06:28:41 -0500
Received: from sushi.toad.net ([162.33.130.105]:53186 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S290643AbSAYL2c>;
	Fri, 25 Jan 2002 06:28:32 -0500
Subject: Re: RFC: booleans and the kernel
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Jan 2002 06:28:37 -0500
Message-Id: <1011958120.1219.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> A small issue...

... bound therefore to generate the most discussion ...

> C99 introduced _Bool as a builtin type.  The gcc patch for
> it went into cvs around Dec 2000.  Any objections to
> propagating this type and usage of 'true' and 'false' around
> the kernel?

What concerns me is the question of casting.  Will truth always
cast to integer value 1 and falsehood always cast to integer
value 0, and vice versa?  If so then the bool type is a lot
like a "bit" type would be if C had one, i.e., a very short
integer variable limited to the values 0 and 1.  If the casts
are not guaranteed then bool is a lot like an enumerated type
where the compiler is free to choose whatever representations
it wants for truth and falsehood.

I assume the casts are guaranteed.  E.g., I take it that the
result of a logical comparison is considered to be of type
bool, but that the following will increment val by 1 if a > b
    val += (a > b)

In that case, perhaps it would be more perspicuous to define
a "bit" type rather than a "bool" type, and to use 0 and 1 as
its values rather than 'true' and 'false'.  (A "bit" type 
would have all the advantages mentioned earlier by Peter Anvin
http://marc.theaimsgroup.com/?l=linux-kernel&m=101191106124169&w=2 .)

--
Thomas Hood

