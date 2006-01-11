Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWAKPB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWAKPB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWAKPB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:01:56 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:19356 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932403AbWAKPBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:01:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MXMFqHR5oKm/oZkUbFx/Otp4t+gp77NgSJkEjfYkBPNvC7tRBOuobMFqJDlOMRMEDplFxkcaubt2YIfLwNif5hPeVI7FPswHyH94uBRpdWf6KocNtniVXDu/oz8oBXkbfrwpVp7lOrOH/n7cxUAvSnqRQmwiNDbOU9CozfrGqbo=
Message-ID: <58cb370e0601110701t1b7859f9i1a13f5a915de6043@mail.gmail.com>
Date: Wed, 11 Jan 2006 16:01:51 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CFT 1/3] Add ide_bus_type probe and remove methods
Cc: LKML <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>,
       IDE <linux-ide@vger.kernel.org>
In-Reply-To: <20060106114059.13.30@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	 <20060106114059.13.30@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Russell King <rmk@arm.linux.org.uk> wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> (This is an additional patch - on lkml, see
>  "[CFT 1/29] Add bus_type probe, remove, shutdown methods.")

Looks fine but shouldn't it also update drivers/scsi/ide-scsi.c?

With ide-scsi.c updated it is is fine with me:

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> ---
>  drivers/ide/ide-cd.c     |   14 +++++---------
>  drivers/ide/ide-disk.c   |   22 ++++++++--------------
>  drivers/ide/ide-floppy.c |   14 +++++---------
>  drivers/ide/ide-tape.c   |   18 +++++++-----------
>  drivers/ide/ide.c        |   31 +++++++++++++++++++++++++++++++
>  include/linux/ide.h      |    5 +++++
>  6 files changed, 61 insertions(+), 43 deletions(-)
