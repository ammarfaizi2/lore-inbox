Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTKWWyf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTKWWyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:54:35 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:24965 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263522AbTKWWye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:54:34 -0500
Message-ID: <3FC13AA0.9030204@colorfullife.com>
Date: Sun, 23 Nov 2003 23:54:24 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix locking in input
References: <3FC13382.3060701@colorfullife.com> <20031123223443.A560@flint.arm.linux.org.uk>
In-Reply-To: <20031123223443.A560@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sun, Nov 23, 2003 at 11:24:02PM +0100, Manfred Spraul wrote:
>  
>
>>I think one platform (early ARM?) cannot access bytes directly, and 
>>implement the access with read 16-bit, change 8-bit, write back 16 bit. 
>>    
>>
>
>Nope.
>
It seems it's Alpha:

On Thu, 28 Dec 2000, Linus wrote:

>FreeBSD doesn't try to be portable any more, but Linux does, and there are
>architectures where 8- and 16-bit accesses aren't *atomic* but have to be
>done with read-modify-write cycles.
>
>And even for fields like "age", where we don't care whether the age itself
>is 100% accurate, we _do_ care that the fields close-by don't get strange
>effects from updating "age". We used to have exactly this problem on alpha
>back in the 2.1.x timeframe.
>


--
    Manfred

