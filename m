Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbUJ1Rcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUJ1Rcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbUJ1Rcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:32:50 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:43998 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263014AbUJ1RcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:32:12 -0400
Message-ID: <41812D09.4060601@colorfullife.com>
Date: Thu, 28 Oct 2004 19:31:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: slab errors
References: <20041028091204.GB1618@wotan.suse.de>
In-Reply-To: <20041028091204.GB1618@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Hi,
>
>I get this when booting 2.6.10rc1-bk6 on x86-64. slab doesn't seem
>to like its own initialization.
>
>  
>
I'm not aware of any slab changes. Were there any changes to the memset 
function? I think slab debug is the only codepath that uses memset to 
nonzero values.

>       
>0000010001102450: redzone 1: 0x5a2cf071, redzone 2: 0x5a2c5a5a.
>  
>
Extremely odd: a byte in the middle no overwritten?

>       
>0000010001102868: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf05a.
>  
>
Two bytes not overwritten.

>0000010001103098: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a5a5a.
>  
>
Everything overwritten.

--
    Manfred
