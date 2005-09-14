Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVINJRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVINJRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVINJRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:17:51 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:62668 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S965098AbVINJRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:17:51 -0400
Message-ID: <4327EA6B.6090102@colorfullife.com>
Date: Wed, 14 Sep 2005 11:16:27 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: David Chinner <dgc@sgi.com>, Bharata B Rao <bharata@in.ibm.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk
 enough
References: <20050911105709.GA16369@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <200509141101.16781.ak@suse.de>
In-Reply-To: <200509141101.16781.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>The slab datastructures are not completely suited for this right now,
>but it could be done by using one more of the list_heads in struct page
>for slab backing pages.
>
>  
>
I agree, I even started prototyping something a year ago, but ran out of 
time.
One tricky point are directory dentries: As far as I see, they are 
pinned and unfreeable if a (freeable) directory entry is in the cache.

--
    Manfred
