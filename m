Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVLNQaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVLNQaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVLNQaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:30:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:29331 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964833AbVLNQae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:30:34 -0500
Message-ID: <43A048A1.6050705@us.ibm.com>
Date: Wed, 14 Dec 2005 08:30:25 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/6] Slab Prep: slab_destruct()
References: <439FCECA.3060909@us.ibm.com> <439FD08E.3020401@us.ibm.com> <84144f020512140037k5d687c66x35e3e29519764fb7@mail.gmail.com>
In-Reply-To: <84144f020512140037k5d687c66x35e3e29519764fb7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 12/14/05, Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>Create a helper function for slab_destroy() called slab_destruct().  Remove
>>some ifdefs inside functions and generally make the slab destroying code
>>more readable prior to slab support for the Critical Page Pool.
> 
> 
> Looks good. How about calling it slab_destroy_objs instead?
> 
>                           Pekka

I called it slab_destruct() because it's the part of the old slab_destroy()
that called the slab destructor to destroy the slab's objects.
slab_destroy_objs() is reasonable as well, though, and I can live with that.

Thanks!

-Matt
