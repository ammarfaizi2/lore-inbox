Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWDZWWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWDZWWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWDZWWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:22:54 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:33296 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964861AbWDZWWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:22:54 -0400
Message-ID: <444FF2BC.5010504@vmware.com>
Date: Wed, 26 Apr 2006 15:22:52 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "Brunner, Richard" <Richard.Brunner@amd.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Hugh Dickins <hugh@veritas.com>,
       Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
References: <99F8FA0D1537DC4EB2A639E8E60D782A6288D0@SAUSEXMB3.amd.com>
In-Reply-To: <99F8FA0D1537DC4EB2A639E8E60D782A6288D0@SAUSEXMB3.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brunner, Richard wrote:
>  
>   
> Maybe the barrier is needed for other architectures, but two writes
> to WB memory are not going to happen out of order and so no
> barrier is needed on x86 to the best of my knowledge.
>   

The barrier here is just a compiler barrier - wmb on x86 is just asm 
volatile ("" ::: "memory");  This is needed to stop gcc reordering the 
stores - not because the processor does respect them.

Zach
