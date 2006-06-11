Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWFKLDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWFKLDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFKLDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 07:03:53 -0400
Received: from stats.hypersurf.com ([209.237.0.12]:4883 "EHLO
	stats.hypersurf.com") by vger.kernel.org with ESMTP
	id S1750771AbWFKLDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 07:03:52 -0400
From: HighPoint Linux Team <linux@highpoint-tech.com>
Organization: HighPoint Technologies, Inc.
To: James.Bottomley@SteelEye.com
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Date: Sun, 11 Jun 2006 19:18:08 +0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org
References: <200606111706.52930.linux@highpoint-tech.com>
In-Reply-To: <200606111706.52930.linux@highpoint-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606111918.08529.linux@highpoint-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 June 2006 05:07 pm, HighPoint Linux Team wrote:
>>
>>	host->can_queue = le32_to_cpu(iop_config.max_requests);
>>	host->cmd_per_lun = le32_to_cpu(iop_config.max_requests);
>> 
>> You might want to think about adjusting this.  For the single LUN case,
>> it's fine.  For the multi-lun case it may allow commands to a single LUN
>> to starve everything else.
>
>There will be no multi-lun support for the controller so this is not
>an issue.

Sorry, a mistake. Multi-lun is supported.
Should host->can_queue be set to (cmd_per_lun * max_lun) ?

