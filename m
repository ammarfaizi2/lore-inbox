Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269901AbRHEByV>; Sat, 4 Aug 2001 21:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269900AbRHEByL>; Sat, 4 Aug 2001 21:54:11 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:29968 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269896AbRHEByB>;
	Sat, 4 Aug 2001 21:54:01 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: lcressy@telocity.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Boot Failure 
In-Reply-To: Your message of "Sat, 04 Aug 2001 15:26:04 -0400."
             <3B6C4C4C.D15A625C@telocity.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Aug 2001 11:54:05 +1000
Message-ID: <2295.996976445@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2001 15:26:04 -0400, 
LeRoy Cressy <lcressy@telocity.com> wrote:
>Starting with kernel 2.4.5 the system refused to boot with the following
>messages:
>2.4.7:
>
>CPU #0: Machine check exception 0x 106B60 (type 0x      9).

In arch/i386/kernel/bluesmoke.c, function intel_mcheck_init, find
        if(c->x86 == 5)
        {
and insert 'return;' after '{'.  The P5 machine check handler does not
work for all systems, reason unknown.

