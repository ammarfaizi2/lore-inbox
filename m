Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSDXKU4>; Wed, 24 Apr 2002 06:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSDXKUz>; Wed, 24 Apr 2002 06:20:55 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:50670 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S311587AbSDXKUy>; Wed, 24 Apr 2002 06:20:54 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 24 Apr 2002 04:18:44 -0600
To: Huo Zhigang <zghuo@gatekeeper.ncic.ac.cn>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: your mail
Message-ID: <20020424101844.GZ3017@turbolinux.com>
Mail-Followup-To: Huo Zhigang <zghuo@gatekeeper.ncic.ac.cn>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <7754BE291293.AAA6418@gatekeeper.ncic.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2002  17:44 +0800, Huo Zhigang wrote:
>   Remove the driver first befor reboot! It works. But what is relation
> between the reboot process and my driver? When I remove the driver module
> myself, nothing goes wrong. What is the difference?

Does your module have a timer or thread which may be active at shutdown?
It may be that if it has a kernel thread that the TERM will kill the
thread and your driver does not expect this.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

