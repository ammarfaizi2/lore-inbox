Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSIJRya>; Tue, 10 Sep 2002 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSIJRya>; Tue, 10 Sep 2002 13:54:30 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:55306 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317073AbSIJRya>; Tue, 10 Sep 2002 13:54:30 -0400
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block size problem
References: <20020910144452.GA29827@atrey.karlin.mff.cuni.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 11 Sep 2002 02:58:51 +0900
In-Reply-To: <20020910144452.GA29827@atrey.karlin.mff.cuni.cz>
Message-ID: <87d6rlbuas.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

>   Hello,
> 
>   my friend has a following problem: He has FAT filesystem on MO disk
>   and computer with SCSI drive reading MO disk. The problem is that
>   smallest blocksize supported by the driver is larger than 512 bytes
>   which FAT needs. What is the right solution?

AFAIK, since originally FAT driver also isn't supporting blocksize
smaller than device sector size, I think he should use blocksize
larger than device sector size.

for example,

    $ mkdosfs -S 2048 /dev/xxx

>   Another solution I though about is creating loopback directly to
>   device but loopback device supports only blocksize same as
>   underlying device... So do you think it would be nice/useful if
>   loopback device supported any blocksize?

Since it isn't the problem of only FAT, I think it would be useful.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
