Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVBCAlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVBCAlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVBCAjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:39:48 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:51014 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262822AbVBCAgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:36:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V/cw17t4QmwDSW1HYDZyoSWqJi8CfGQILyNmfDAzffmLZbcO6VK5EYZYJpKFHlskbenp0VX+93cZHy/vn0pJ2rBskbg6SLxz/6TVNo0LbE5ZS6vtd4vfcXeB09n65vGB9A6ztpgEnV0RCieXsM8UbudpwF4EtOTPWLcfclY61sY=
Message-ID: <58cb370e050202163644e934d0@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:36:47 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 10/29] ide: __ide_do_rw_disk() return value fix
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025248.GK621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025248.GK621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:52:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 10_ide_do_rw_disk_pre_task_out_intr_return_fix.patch
> >
> >       In __ide_do_rw_disk(), ide_started used to be returned blindly
> >       after issusing PIO write.  This can cause hang if
> >       pre_task_out_intr() returns ide_stopped due to failed
> >       ide_wait_stat() test.  Fixed to pass the return value of
> >       pre_task_out_intr().
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
