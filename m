Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVBLCCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVBLCCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 21:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVBLCAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 21:00:07 -0500
Received: from siaag1ae.compuserve.com ([149.174.40.7]:2440 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262179AbVBLB7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:59:23 -0500
Date: Fri, 11 Feb 2005 20:55:15 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2.6.11-rc3 06/11] ide: make disk flush functions
  use TASKFILE instead
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200502112058_MC3-1-95CC-5FF0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 at 17:38:39 +0900, Tejun Heo wrote:

> -         (drive->capacity64 >= (1UL << 28)))
> -             rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> +         (drive->capacity64 >= (1UL << 28))) {
> +             task->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;


  Shouldn't that be "(drive->capacity64 > (1UL << 28))" ??

--
Chuck
