Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTDWPrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTDWPrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:47:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42836 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id S264093AbTDWPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:47:14 -0400
Date: Wed, 23 Apr 2003 11:59:16 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: Re: [PATCH]  Undefined symbol sync_dquots_dev() in quota.c
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3EA6B854.5010604@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
References: <3EA6B13A.4000408@videotron.ca> <20030423153341.GA5561@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>On Wed, Apr 23, 2003 at 11:28:58AM -0400, Stephane Ouellette wrote:
>  
>
>>Folks,
>>
>>  the following patch fixes a compile error under 2.4.21-rc1-ac1. 
>>sync_dev_dquots() is undefined if CONFIG_QUOTA is not set.
>>    
>>
>
>The right fix would be to make sure a no-op version of sync_dev_dquots
>exists for that case.
>
>	Jeff
>  
>

Jeff,

   the file fs/dquot.c is compiled only if CONFIG_QUOTA is set.  That 
would imply modifying the Makefile and #ifdeffing most of the code 
inside dquot.c.

Stephane.

>  
>

