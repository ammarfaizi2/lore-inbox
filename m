Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSIJR6p>; Tue, 10 Sep 2002 13:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSIJR6o>; Tue, 10 Sep 2002 13:58:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:11021 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317473AbSIJR6o>; Tue, 10 Sep 2002 13:58:44 -0400
Date: Tue, 10 Sep 2002 20:03:31 +0200
From: Jan Kara <jack@suse.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block size problem
Message-ID: <20020910180331.GB18476@atrey.karlin.mff.cuni.cz>
References: <20020910144452.GA29827@atrey.karlin.mff.cuni.cz> <87d6rlbuas.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6rlbuas.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> writes:
> 
> >   Hello,
> > 
> >   my friend has a following problem: He has FAT filesystem on MO disk
> >   and computer with SCSI drive reading MO disk. The problem is that
> >   smallest blocksize supported by the driver is larger than 512 bytes
> >   which FAT needs. What is the right solution?
> 
> AFAIK, since originally FAT driver also isn't supporting blocksize
> smaller than device sector size, I think he should use blocksize
> larger than device sector size.
> 
> for example,
> 
>     $ mkdosfs -S 2048 /dev/xxx
  Sadly that isn't a choice because disks are created by EWSD phone
  exchange...
  
> >   Another solution I though about is creating loopback directly to
> >   device but loopback device supports only blocksize same as
> >   underlying device... So do you think it would be nice/useful if
> >   loopback device supported any blocksize?
> 
> Since it isn't the problem of only FAT, I think it would be useful.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
