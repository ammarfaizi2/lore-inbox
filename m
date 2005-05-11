Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVEKQTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVEKQTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVEKQTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:19:31 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:41964 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261212AbVEKQTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:19:12 -0400
Message-ID: <4282307D.8060307@freenet.de>
Date: Wed, 11 May 2005 18:19:09 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
References: <428216F7.30303@de.ibm.com>	 <20050511150924.GA29976@infradead.org>  <428225E7.4070605@freenet.de> <1115826428.26913.1069.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1115826428.26913.1069.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

> While I agree with your reasoning, since you are affecting very hot
>
>code path for every architecture, irrespective of "bdev" support
>for this - you may want to look into some how eliminating few
>function pointer de-refs and checks for those who don't care.
>(#ifdef, unlikely(), or some arch & config magic).
>  
>
I do agree that addidional pointer derefs would be a nightmare
from the performance perspective. But afaics the patch does not
add such, and for checks I did already add likeleyness for the non-xip
case. Could you be more precise and specify which code path(es) you
mean?

>To be honest, that file is already complicated enough - every time
>I look at it my head hurts :(
>  
>
I agree on that one. I gonna put extra functions into its own file.
