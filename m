Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWINCbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWINCbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 22:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWINCbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 22:31:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:58753 "EHLO
	asav06.insightbb.com") by vger.kernel.org with ESMTP
	id S1750801AbWINCbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 22:31:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAEpbCEWBTooULA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [03/12] driver core fixes: fixup platform_device_register_simple()
Date: Wed, 13 Sep 2006 22:31:05 -0400
User-Agent: KMail/1.9.3
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com> <20060913183840.5a2e4989@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913183840.5a2e4989@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609132231.06346.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 13 September 2006 12:38, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Remember to remove allocated resources if platform_device_add() fails.
> Introduce a helper function platform_device_del_resources() for this,
> which can also be used by platform_device_del().
> 

platform_device_add() already releases all resources in case of failure.
Memory allocated for resource structures is released by
platform_device_release(). I do not think this patch is needed.

As fas as platform_device_register_somple() goes it should just die and
users should be converted to platofrm_device_alloc/add.

-- 
Dmitry
