Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWCBBOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCBBOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCBBOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:14:25 -0500
Received: from dvhart.com ([64.146.134.43]:38571 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751248AbWCBBOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:14:25 -0500
Message-ID: <440646ED.2030108@mbligh.org>
Date: Wed, 01 Mar 2006 17:14:21 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Fix powerpc bad_page_fault output  (Re: 2.6.16-rc5-mm1)
References: <20060228042439.43e6ef41.akpm@osdl.org>	<4404E328.7070807@mbligh.org>	<20060301164531.GA17755@pb15.lixom.net> <17414.15814.146349.883153@cargo.ozlabs.ibm.com>
In-Reply-To: <17414.15814.146349.883153@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Olof Johansson writes:
> 
> 
>>Seems that the human-readible parts are printed at a differnet printk level
>>(well, _at_ a level), so they fell off. Not good.
> 
> 
> My understanding was that printk lines without a level are considered
> to be at KERN_ERR or so.  Is that wrong?
> 
> 
>>Andrew and/or Paulus, see patch below.
> 
> 
> It really seems strange to be *removing* printk level tags.  I'd like
> to nack this until I understand why it will improve things.  At the
> very least it needs a big fat comment so some janitor doesn't come
> along and put the tags back in.

He's removing KERN_ALERT ... I guess it could get switched from 
KERN_ALERT to KERN_ERR, but ...

Either way, KERN_ALERT seems way too low to me. I object to getting
half the oops, and not the other half ;-)

M.
