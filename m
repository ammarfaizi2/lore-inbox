Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267320AbUBSPVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbUBSPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:21:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267305AbUBSPVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 10:21:30 -0500
Message-ID: <4034D46B.4020204@pobox.com>
Date: Thu, 19 Feb 2004 10:21:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joilnen Leite <pidhash@yahoo.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ide-scsi lock
References: <20040219135311.95851.qmail@web12603.mail.yahoo.com>
In-Reply-To: <20040219135311.95851.qmail@web12603.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joilnen Leite wrote:
> drivers/scsi/ide-scsi.c:897
> 
> spin_lock_irqsave(&ide_lock, flags);
> while (HWGROUP(drive)->handler) {
>        HWGROUP(drive)->handler = NULL;
>        schedule_timeout(1);
> }


Yep, that's definitely a bug.  Good spotting.

	Jeff



