Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130998AbQKAFjQ>; Wed, 1 Nov 2000 00:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbQKAFjG>; Wed, 1 Nov 2000 00:39:06 -0500
Received: from hermes.mixx.net ([212.84.196.2]:65289 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130998AbQKAFi5>;
	Wed, 1 Nov 2000 00:38:57 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Date: Wed, 01 Nov 2000 06:38:55 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-39FFAC6F.65107F2D@innominate.de>
In-Reply-To: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu> <39FF3F0B.81A1EE13@timpanogas.org> <20001031230538.A9048@gruyere.muc.suse.de> <39FF465F.4EEB811A@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 973057135 19266 10.0.0.90 (1 Nov 2000 05:38:55 GMT)
X-Complaints-To: news@innominate.de
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test8 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> A "context" is usually assued to be a "stack".  The simplest of all
> context switches is:
> 
>    mov    x, esp
>    mov    esp, y

Presumeably you'd immediately do a ret to some address, and there pop a
base address off the stack to get some global memory.  Is that right? 
Your context switches would be inline, and you'd have hardcoded which
process to execute next in most cases.

I'll buy the concept that changing stacks amounts to changing contexts,
so long as you follow certain rules.  Obviously, rules are what define a
context.  What are the two instructions that precede and the two
instructions that follow?  I'd guess, something like this:

   push bp
   push $1
   mov x, esp
   mov esp, y
   ret
$1 pop bp

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
