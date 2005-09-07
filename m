Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVIGO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVIGO5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVIGO5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:57:53 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11395 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932153AbVIGO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:57:53 -0400
Message-ID: <431EFFE7.6070709@us.ibm.com>
Date: Wed, 07 Sep 2005 09:57:43 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Santiago Leon <santil@us.ibm.com>,
       Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
References: <20050906212801.GB14057@cs.umn.edu> <20050907025932.GU6945@krispykreme>
In-Reply-To: <20050907025932.GU6945@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

> +	adapter->max_sectors = MAX_SECTORS;
> 
> Does this mean we are limited to 128kB transfers? Would it be OK to
> bump the default?

We use MAX_SECTORS (which is actually 127.5kB) because that's the 
max_sectors of the loopback device (we have a lot of users that like the 
flexibility of using loopback with the ibmvscsis driver)... It can be 
bumped up without any problems because there is code that splits 
requests if they are larger than the target's max_sectors...

What would you recommend? 256kB?

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

