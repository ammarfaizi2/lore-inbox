Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUJNSOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUJNSOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJNSOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:14:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52096 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266467AbUJNRFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:05:11 -0400
Message-ID: <416EB1B6.5070603@pobox.com>
Date: Thu, 14 Oct 2004 13:04:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export ata_scsi_simulate() for use by non-libata drivers
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca> <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca> <416DAF1A.2040204@pobox.com> <416DB912.7040805@rtr.ca> <416DBC96.2090602@pobox.com> <416EA996.4040402@rtr.ca> <416EAECC.7070000@rtr.ca>
In-Reply-To: <416EAECC.7070000@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> +void ata_scsi_simulate(u16 *id,
> +		      struct scsi_cmnd *cmd,
> +		      void (*done)(struct scsi_cmnd *));

That you are defining a public function in multiple files should be a 
hint that something is still missing...  :)  Put a prototype in 
linux/libata.h just like the other public functions, and the patch will 
be OK.

	Jeff


