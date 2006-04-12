Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWDLNz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWDLNz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWDLNz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:14466 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751034AbWDLNz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:55:58 -0400
Message-ID: <443D06DE.8060903@suse.de>
Date: Wed, 12 Apr 2006 15:55:42 +0200
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org, gibbs@scsiguy.com,
       eike-kernel@sf-tec.de, stefanr@s5r6.in-berlin.de
Subject: Re: [PATCH 1/2] aic7xxx: deinline large functions, save 80k of text
References: <200604120945.34419.vda@ilport.com.ua>
In-Reply-To: <200604120945.34419.vda@ilport.com.ua>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> This patch
> 
> moves big inlines into aic79xx_core.c and aic7xxx_core.c
> makes ahd_delay just a wrapper around udelay
> marks a few functions static
> fixes spelling fix in error message
While you're at it; can't you move the different ah{c,d}_{in,out}.* into
one place? Have them scattered throughout the file doesn't really make
sense.

Otherwise ACK.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
