Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967255AbWK2OV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967255AbWK2OV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967257AbWK2OV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:21:27 -0500
Received: from emulex.emulex.com ([138.239.112.1]:12790 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S967255AbWK2OV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:21:26 -0500
Message-ID: <456D958F.2080305@emulex.com>
Date: Wed, 29 Nov 2006 09:13:35 -0500
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/scsi_error.c should #include "scsi_transport_api.h"
References: <20061129100422.GL11084@stusta.de> <20061129131624.GV14076@parisc-linux.org>
In-Reply-To: <20061129131624.GV14076@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2006 14:13:35.0742 (UTC) FILETIME=[8F0449E0:01C713C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Wilcox wrote:
> On Wed, Nov 29, 2006 at 11:04:22AM +0100, Adrian Bunk wrote:
>> +#include "scsi_transport_api.h"
> 
> scsi_transport_api.h is a weird little file.  It's not included by
> anything in the drivers/scsi directory, only
> drivers/scsi/libsas/sas_scsi_host.c:#include "../scsi_transport_api.h"
> drivers/ata/libata-eh.c:#include "../scsi/scsi_transport_api.h"
> 
> To me, that says it should be living in include/scsi/ somewhere ...
> maybe just put the one function prototype into scsi_eh.h?

would it only go in include/scsi if it intends to be an exported
api for LLDD's and/or user apps ?  and stay in drivers/scsi if its
an internal api within the scsi subsystem itself ?

Based on who uses it, I would say its internal right now.

-- james s
