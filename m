Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263591AbUEHKcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUEHKcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUEHKcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:32:25 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:50561 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263591AbUEHKcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:32:19 -0400
Message-ID: <409CB71E.9020602@colorfullife.com>
Date: Sat, 08 May 2004 12:31:58 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: davej@redhat.com, torvalds@osdl.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
References: <20040506200027.GC26679@redhat.com>	<20040506150944.126bb409.akpm@osdl.org>	<409B1511.6010500@colorfullife.com>	<20040508012357.3559fb6e.akpm@osdl.org>	<20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
In-Reply-To: <20040508031159.782d6a46.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Andrew Morton <akpm@osdl.org> wrote:
>  
>
>>Here be another patch.
>>    
>>
>
>
>Can't help myself!
>
>
>- d_vfs_flags can be removed - just use d_flags.  It looks like someone
>  added d_vfs_flags with the intent of doing bitops on it, but all
>  modifications are under dcache_lock.  4 bytes saved.
>  
>
IIRC it was intended to access one of the flag fields under dentry->d_lock.

--
    Manfred

