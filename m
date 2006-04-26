Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWDZQQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWDZQQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWDZQQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:16:34 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:20129 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964804AbWDZQQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:16:33 -0400
In-Reply-To: <Pine.LNX.4.64.0604261652320.12529@blonde.wat.veritas.com>
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com> <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk> <444F955A.6050206@vmware.com> <Pine.LNX.4.64.0604261652320.12529@blonde.wat.veritas.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fea09d592b7075d7c7525ba294a15b0f@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
Date: Wed, 26 Apr 2006 17:12:44 +0100
To: Hugh Dickins <hugh@veritas.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Apr 2006, at 16:57, Hugh Dickins wrote:

>> Proposed fix for ptep_get_and_clear_full PAE bug.  Pte_clear had the 
>> same
>> bug, so use the same fix for both.
>
> You need to expand that comment with text from Jan & Keir's patch:
> Andrew will want to know just what this bug was.  The patch looks
> good to me, except for the unnecessary do { } while (0) in the
> definition of pte_clear: ah, you're only copying what was already
> there, can't blame you for that, let's not worry about it.

I agree: the patch comment is rather brief, but the patch itself looks 
good. I suppose switching PAE's set_pte() from smp_wmb() to wmb() would 
logically belong in a separate patch.

  -- Keir

