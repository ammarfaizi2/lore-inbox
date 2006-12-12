Return-Path: <linux-kernel-owner+w=401wt.eu-S932319AbWLLScx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWLLScx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWLLScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:32:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:7210 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932319AbWLLScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:32:51 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,525,1157353200"; 
   d="scan'208"; a="173583716:sNHT17476893"
Message-ID: <457EF5CE.2030404@intel.com>
Date: Tue, 12 Dec 2006 10:32:46 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Yan Burman <burman.yan@gmail.com>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.19] e1000: replace kmalloc with kzalloc
References: <1165942389.5611.4.camel@localhost> <84144f020612120934n612f513er606d2653f527eb67@mail.gmail.com>
In-Reply-To: <84144f020612120934n612f513er606d2653f527eb67@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 12/12/06, Yan Burman <burman.yan@gmail.com> wrote:
>>         size = txdr->count * sizeof(struct e1000_buffer);
>> -       if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
>> +       if (!(txdr->buffer_info = kzalloc(size, GFP_KERNEL))) {
>>                 ret_val = 1;
>>                 goto err_nomem;
>>         }
>> -       memset(txdr->buffer_info, 0, size);
> 
> No one seems to be using size elsewhere so why not convert to
> kcalloc() and get rid of it? (Seems to apply to other places as well.)

I'll put it on my todo list.

Auke
