Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVHQPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVHQPMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVHQPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:12:37 -0400
Received: from dns.suna-asobi.com ([210.151.31.146]:23176 "EHLO
	dns.suna-asobi.com") by vger.kernel.org with ESMTP id S1751131AbVHQPMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:12:36 -0400
Date: Thu, 18 Aug 2005 00:18:58 +0900
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: math_state_restore() question
Cc: taka@valinux.co.jp, lkml.hyoshiok@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050817.174222.1025215937.hyoshiok@miraclelinux.com>
References: <20050817.170700.34136678.taka@valinux.co.jp> <20050817.174222.1025215937.hyoshiok@miraclelinux.com>
Message-Id: <20050818001403.6E8A.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Aug 2005 17:42:22 +0900 (JST)
Hiro Yoshioka <hyoshiok@miraclelinux.com> mentioned:
> > Just take a look at __switch_to(), where __unlazy_fpu() is called.
> 
> Thanks. Does an exception handler (like page_fault, etc) come 
> from __switch_to()?

No, page_fault is generated when the location of memory access(virtual) 
does not have physical memory.

If you have a code like this,
   movq   (%%esi), %%mm0
a page of address %%esi might be swapped out already and might not 
have any physical memory page allocated.


-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


