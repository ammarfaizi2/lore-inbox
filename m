Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUFPTAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUFPTAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUFPTAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:00:37 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:41629 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264530AbUFPS7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:59:22 -0400
Message-ID: <40D09872.4090107@colorfullife.com>
Date: Wed, 16 Jun 2004 20:58:58 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
CC: linux-kernel@vger.kernel.org, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-mm@kvack.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
References: <40D08225.6060900@colorfullife.com> <20040616180208.GD6069@sgi.com>
In-Reply-To: <20040616180208.GD6069@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich wrote:

>>Do you use the default batchcount values or have you increased the values?
>>    
>>
>
>Default.
>
>  
>
Could you try to reduce them? Something like (as root)

# cd /proc
# cat slabinfo | gawk '{printf("echo \"%s %d %d %d\" > 
/proc/slabinfo\n", $1,$9,4,2);}' | bash

If this doesn't help then perhaps the timer should run more frequently 
and scan only a part of the list of slab caches.

--
    Manfred
