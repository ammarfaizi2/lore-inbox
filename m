Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSESRxK>; Sun, 19 May 2002 13:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314705AbSESRxJ>; Sun, 19 May 2002 13:53:09 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:31227 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314702AbSESRxJ>; Sun, 19 May 2002 13:53:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E179Qxm-0003nQ-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rui.sousa@laposte.net (Rui Sousa), rusty@rustcorp.com.au (Rusty Russell),
        linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 19 May 2002 18:52:36 +0100
Message-ID: <12687.1021830756@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > On the emu10k1 driver we use access_ok(VERIFY_READ) once at the
> > beginning of the write() routine to check we can access the user buffer.
> > After that we always use __copy_from_user() and we trust it not to fail. 
> > Is this correct, or not?

> This is correct 

Even if another thread unmaps the page we were trying to read from between 
the access_ok() and the actual copy?

--
dwmw2


