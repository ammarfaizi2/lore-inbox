Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUBKSk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUBKSk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:40:59 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:60577 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S266128AbUBKSk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:40:57 -0500
Message-ID: <402A7765.FD5A7F9E@users.sourceforge.net>
Date: Wed, 11 Feb 2004 20:41:41 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Kwolek <miho@centrum.cz>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402A4B52.1080800@centrum.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Kwolek wrote:
> I've got a reproducible oops when using cryptoloop on vanilla 2.6.0,
> 2.6.1 and 2.6.2 (2.4.* works fine).
> 
> Way to reproduce:
> dd if=/dev/urandom of=crypto bs=1024 count=some_size
> losetup -e some_cipher /dev/loop0 crypto
> #Any of those commands causes oops and hard lockup:
> cp /dev/loop0 /dev/null
> mkreiserfs /dev/loop0
> mkfs.ext2 /dev/loop0
> 
> Loop without cryptoapi works fine:
> dd if=/dev/urandom of=crypto bs=1024 count=some_size
> losetup /dev/loop0 crypto
> cp /dev/loop0 /dev/null
> #ok, no oops

Can you try again using loop-AES? loop-AES does not fall apart like the
mainline implementation does. loop-AES is here:

http://mail.nl.linux.org/linux-crypto/2004-02/msg00006.html

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
