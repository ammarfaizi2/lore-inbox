Return-Path: <linux-kernel-owner+w=401wt.eu-S1751732AbXAPXDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbXAPXDV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbXAPXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:03:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36390 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbXAPXDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:03:20 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH 45/59] sysctl: C99 convert ctl_tables in drivers/parport/procfs.c
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656733768-git-send-email-ebiederm@xmission.com>
	<200701162315.56454.ioe-lkml@rameria.de>
Date: Tue, 16 Jan 2007 16:00:56 -0700
In-Reply-To: <200701162315.56454.ioe-lkml@rameria.de> (Ingo Oeser's message of
	"Tue, 16 Jan 2007 23:15:43 +0100")
Message-ID: <m1wt3ma85z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> Hi Eric,
>
> On Tuesday, 16. January 2007 17:39, Eric W. Biederman wrote:
>> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
>> index 2e744a2..5337789 100644
>> --- a/drivers/parport/procfs.c
>> +++ b/drivers/parport/procfs.c
>> @@ -263,50 +263,118 @@ struct parport_sysctl_table {
>> +		{
>> +			.ctl_name	= DEV_PARPORT_BASE_ADDR,
>> +			.procname	= "base-addr",
>> +			.data		= NULL,
>> +			.maxlen		= 0,
>> +			.mode		= 0444,
>> +			.proc_handler	= &do_hardware_base_addr
>> +		},
>
> No need to initialize to zero or NULL. Just list any variable, which is NOT zero
> or NULL.

Agreed.  In this case it was left for clarity.

>> +		{
>> +			.ctl_name	= DEV_PARPORT_AUTOPROBE + 1,
>> +			.procname	= "autoprobe0",
>> +			.data		= NULL,
>> +			.maxlen		= 0,
>> +			.maxlen		= 0444,
>> +			.proc_handler	=  &do_autoprobe
>> +		},
>
> Typo here? .mode = 0444 makes mor sense.

Yep looks like it.  On my todo.

Eric
