Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSDJWEA>; Wed, 10 Apr 2002 18:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313909AbSDJWD7>; Wed, 10 Apr 2002 18:03:59 -0400
Received: from linuxfromscratch.org ([198.186.203.81]:57873 "EHLO
	linuxfromscratch.org") by vger.kernel.org with ESMTP
	id <S313906AbSDJWD6>; Wed, 10 Apr 2002 18:03:58 -0400
Date: Wed, 10 Apr 2002 18:03:52 -0400
From: Gerard Beekmans <gerard@linuxfromscratch.org>
To: "Herbert G. Fischer" <nospam@pontoip.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Full RAM problem with IDE UDMA active
Message-ID: <20020410220352.GA778@gwaihir.linuxfromscratch.org>
In-Reply-To: <20020410213044.8661.qmail@hm60.locaweb.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Linux From Scratch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 06:30:44PM +0000, Herbert G. Fischer wrote:
> When I do varios disk read-write operations (ex.: copying some ISO from one 
> partition to another), my RAM gets almost FULL. It keeps growing in usage 
> during the read-write operation. But when the operation finishes, the memory 
> keeps FULL, even after running a sync command. The swap isn't used in 
> this case.
> 
> I think that UDMA uses a lot of memory without deallocing it.
> 
> Look:
>              total       used       free     shared    buffers     cached
> Mem:        772368     645884     126484          0      85072     393896
> -/+ buffers/cache:     166916     605452
> Swap:      1044188          0    1044188

It may appear that you only have 126,484 KB free RAM, but that doesn't
include the cached memory. The second line shows your actual free RAM which
is 605,452 KB (roughly 590 MB free out of 750 MB or so RAM). This memory
(cached) will be made available to the system when something needs it.
 
-- 
Gerard Beekmans
www.linuxfromscratch.org

-*- If Linux doesn't have the solution, you have the wrong problem -*-
