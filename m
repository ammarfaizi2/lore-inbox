Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSA1Bj5>; Sun, 27 Jan 2002 20:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289082AbSA1Bjr>; Sun, 27 Jan 2002 20:39:47 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:25242 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S289081AbSA1Bj3>; Sun, 27 Jan 2002 20:39:29 -0500
Date: Mon, 28 Jan 2002 04:38:33 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Paulo Andre'" <l16083@alunos.uevora.pt>
Cc: linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@suse.de>
Subject: Re: Can't compile Symbios 53c416 SCSI support
Message-Id: <20020128043833.659e7102.johnpol@2ka.mipt.ru>
In-Reply-To: <20020127201213.A7091@bleach>
In-Reply-To: <20020127201213.A7091@bleach>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002 20:12:13 +0000
"Paulo Andre'" <l16083@alunos.uevora.pt> wrote:


> sym53c416.c: In function `sym53c416_intr_handle':
> sym53c416.c:362: `io_request_lock' undeclared (first use in this 
> function)
> sym53c416.c:362: (Each undeclared identifier is reported only once
> sym53c416.c:362: for each function it appears in.)

> I'm a newbie though I see <linux/blk.h> is included. Still it says 
> io_request_lock is undeclared... should be trivial but goes beyond my 
> knowledge :)

It seems that io_request_lock will be completely removed in 2.5 tree, so
there is no io_request_lock in linux/blk.h. This global lock now exsist
only in scsi layer, and it will be replaced by Scsi_Host->host_lock soon.
So i hope this patch will help a bit in this direction.

2 Paulo Andre: DON'T use this patch before Jens Axboe will agree with it,
because i even haven't scsi here, so this patch was written only with
common sence. I hope this will help you.

> 
> Thanks in advance
> 
> // Paulo Andre'

	Evgeniy Polyakov ( s0mbre ).
