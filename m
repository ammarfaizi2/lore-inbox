Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbTCRXmK>; Tue, 18 Mar 2003 18:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbTCRXmK>; Tue, 18 Mar 2003 18:42:10 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23687 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262694AbTCRXmJ>;
	Tue, 18 Mar 2003 18:42:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Mar 2003 00:53:04 +0100 (MET)
Message-Id: <UTC200303182353.h2INr3p14431.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, jgarzik@pobox.com
Subject: Re: [PATCH] dev_t [1/3]
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jeff Garzik <jgarzik@pobox.com>

    > So, kill cdev_cachep, cdev_cache_init,
    > cdfind, cdget, cdput, inode->i_cdev, struct char_device.
    > All of this is dead code today.

    You're also removing refcount code... why not fix it up instead?

    I agree your patch is mostly correct from a "today" standpoint,
    but from a long term standpoint ...

Your remarks have been made a few times already, and each
time I answered that my objective was to give Linux 2.6
a 32-bit dev_t, and my objective is not to do work that
is not for 2.6 but for 2.8.

Al made a brief appearance last week - if he decides to do
the character device setup now, that might change things.

If he doesnt do this then I wouldnt mind doing it,
but I suppose dev_t will keep us busy for some more time.
There is good progress on the kernel side, but we also
need some glibc fixes.

Andries
