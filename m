Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424188AbWKIW33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424188AbWKIW33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424201AbWKIW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:29:29 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:8147 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1424188AbWKIW32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:29:28 -0500
Date: Thu, 09 Nov 2006 23:29:34 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Prevent an oops in vmalloc_user()
In-reply-to: <31360.1163109619@lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <4553ABCE.2050006@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <31360.1163109619@lwn.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet a écrit :
> Prevent an oops in vmalloc_user()
> 
> If an attempt to allocate memory with vmalloc_user() fails, the result
> will be an oops when it tries to tweak the flags in the (non-existent)
> VMA.  One could argue that __find_vm_area() should not return a random
> pointer on failure, but vmalloc_user() requires a check regardless.
> 

Yes, I already posted a patch for that, and other problem as well.

http://lkml.org/lkml/2006/10/23/86

Maybe it was lost...

Eric
