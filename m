Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSH0XJA>; Tue, 27 Aug 2002 19:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSH0XJA>; Tue, 27 Aug 2002 19:09:00 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:384 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317329AbSH0XI7>; Tue, 27 Aug 2002 19:08:59 -0400
Date: Wed, 28 Aug 2002 01:21:45 +0200
From: DervishD <raul@pleyades.net>
Organization: Pleyades
Reply-To: DervishD <raul@pleyades.net>
To: mra@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: How can a process easily get a list of all it's open fd?
Message-ID: <3D6C0989.mail6E21O4HV@pleyades.net>
References: <m38z2s1fkj.fsf@khem.blackfedora.com>
In-Reply-To: <m38z2s1fkj.fsf@khem.blackfedora.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mark :)

>So what's the "right way" to do it?

    AFAIK, the for loop, with getdtablesize() instead of 'OPEN_MAX'.
I do it that way, but I don't really know if it is the 'right way'(tm).

>I would *love* for there to be an ioctl or some syscall that I could
>pass a pointer to an int and a pointer to an int array, and it would
>come back telling me how many open fd's I've got, and fill in the
>array with those fd's.

    The array should be allocated by the kernel, or the syscall won't
work as expected ;) If you have 2000 fd open and the array whose
address you pass to the ioctl has an smaller size... Anyway, you can
call the ioctl a few times ;)

    Your proposal seems reasonable (unless there is any other way of
doing this portably), but portability will be an issue...

    Raúl
