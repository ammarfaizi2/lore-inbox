Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbTGCWwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTGCWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:52:06 -0400
Received: from gutemberg-1-81-57-26-150.fbx.proxad.net ([81.57.26.150]:38091
	"EHLO charlus.dyndns.org") by vger.kernel.org with ESMTP
	id S265485AbTGCWvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:51:46 -0400
Message-ID: <3F04B6DA.2040300@ruault.com>
Date: Fri, 04 Jul 2003 01:06:02 +0200
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 , large disk write => system crawls
References: <Pine.LNX.4.44.0307031848420.7338-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0307031848420.7338-100000@coffee.psychology.mcmaster.ca>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>>>>when i do a large disk write operation ( copy a big file for example ), 
>>>>the whole system becomes very busy ( system goes into 99% cpu 
>>>>        
>>>>
>
>it's not write-specific.  you can see below that you're somehow
>managing to trigger roughly two interrupts per *either* bi or bo.
>for a normal IDE setup, you should see one interrupt per 16-64K
>under average use.  it's almost like your sys somehow thinks
>that it can only transfer 1 sector per interrupt!
>  
>
hmmm interesting i had not noticed that !

>  
>
>>everytime i experience a slowdown, there's a 'big' number in the io (bo) 
>>column.
>>    
>>
>
>no, it's basically in=2*(bi+bo), as if your system somehow believes
>it can only do a single sector per interrupt (PIO and -m1 perhaps?)
>it should be more like 32K per interrupt.
>
>  
>
>>Jun 27 22:52:31 charlus kernel: Found and enabled local APIC!
>>    
>>
>
>have you tried without that?
>
>.
>
>  
>
nope. I'll do that for sure. I've already had problems with APIC on 
other systems ...
Thanks for the hint. I'll keep you posted if it works.


-- 
Charles-Edouard Ruault
PGP Key ID E10C24DC


