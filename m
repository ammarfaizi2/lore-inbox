Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSAIULg>; Wed, 9 Jan 2002 15:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAIUJL>; Wed, 9 Jan 2002 15:09:11 -0500
Received: from nile.gnat.com ([205.232.38.5]:52876 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289004AbSAIUIJ>;
	Wed, 9 Jan 2002 15:08:09 -0500
From: dewar@gnat.com
To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020109200808.08942F313A@nile.gnat.com>
Date: Wed,  9 Jan 2002 15:08:08 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<So, I would claim that the case is symetric with writing volatiles.
If the standard doesn't make a distinction for write v read, then you
can't and claim that distinction is based in the standard.  If you
claim the standard does make a distinction, please point it out, I am
unaware of it.
>>

Well obviously you do not go writing to other variables, but if you have
three variables IN ONE PROGRAM

a
b
c

adjacently allocated, and b is volatile, and a/c are not, then your
argument *so far* would appear to allow a compiler to do an "over-wide"
load for b. If you think otherwise, please prove from standard.

Of course a write is generally not at all symmetrical, since you don't
want a write to be to clobber a and c (yes yes, I know you could still
construct a far out case in which a and b might be stored together, and
indeed that is a legitimate separate discussion).
