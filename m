Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317445AbSFCSK5>; Mon, 3 Jun 2002 14:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSFCSK4>; Mon, 3 Jun 2002 14:10:56 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:43061 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S317445AbSFCSKz>; Mon, 3 Jun 2002 14:10:55 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F5110927E7A15@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Atomic operations
Date: Mon, 3 Jun 2002 21:09:22 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Thanks a lot for your help. 

> atomic_t test_then_add (int i, atomic_t* v)
> {
>    atomic_t old = *v;
>    v->counter += i;
>    return old;
> }
> There is no way to do this (without waiting and trying again type
> code) that I know of on i386.  However, you can test for zeroness of
> the result, or for <= 0, or a few other options.

Could you, please, clarify what you meant saying that there was no way of
doing so. I admit, I'm no expert in i386 assembly, but this operation seems
so simple to me...

Could you, please, suggest some other implementation (with waiting and
trying again - whatever this means)?

test_and_set and test_then_add functions are coming from code written for
IRIX. Solaris has similar functionality. Windows NT also provides these
primitives in Win32 API (possibly implemented not in the most effective way,
according to what you say). The only OS where they are missing is Linux. 

Unfortunately, these primitives became an integral part of our code, which
makes it very painful to change their behavior.

Thanks in advance.
Giga
