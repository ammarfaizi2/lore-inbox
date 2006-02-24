Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWBXBBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWBXBBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWBXBBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:01:49 -0500
Received: from mail.suse.de ([195.135.220.2]:47292 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932275AbWBXBBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:01:48 -0500
From: Chris Mason <mason@suse.com>
To: suparna@in.ibm.com
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
Date: Thu, 23 Feb 2006 20:01:32 -0500
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, sct@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org, kenneth.w.chen@intel.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, sonny@burdell.org
References: <20060223072955.GA14244@in.ibm.com>
In-Reply-To: <20060223072955.GA14244@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602232001.34327.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 02:29, Suparna Bhattacharya wrote:
> DIO code complexity and stability concerns were discussed way back during
> OLS and Kernel summit last year. Still, the lack of a solid alternative and
> motivation to subject oneself to the test of courage and delicate balance
> that fiddling with this code entails, has meant that gingerly applying
> fixes and bandaids as and when bugs are found, and moving on thereafter,
> continues to be the most palatable option.
>
> A recent AIO-DIO bug reported by Kenneth Chen, came very close
> to being the proverbial last straw for me. Hence, here is a rough attempt
> to put together a (currently WIP) draft towards DIO code simplication,
> based on suggestions that some of you have brought up at various times.
> Several details, e.g. range locking implementation still need to be fleshed
> out completely, ideas/comments/suggestions would be welcome.

I'm really in favor of this, and had actually started an implementation a 
while back.  At the time, I posted a different version that added yet another 
semaphore but simplified the rest of the locking (and held no locks during 
the dio/aio).

I'll try to dig up my original radix tagging code.  I'm not sure if I kept it, 
but it did pass Daniel's dio vs buffer io racing tests at the time.

-chris
