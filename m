Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293046AbSBWAEL>; Fri, 22 Feb 2002 19:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293052AbSBWAED>; Fri, 22 Feb 2002 19:04:03 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39314 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293046AbSBWADD>; Fri, 22 Feb 2002 19:03:03 -0500
Date: Fri, 22 Feb 2002 19:02:56 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Balbir Singh <balbir_soni@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial patch against mempool
Message-ID: <20020222190256.C16169@redhat.com>
In-Reply-To: <F24fGB9wIWXLU9778dv00003562@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F24fGB9wIWXLU9778dv00003562@hotmail.com>; from balbir_soni@hotmail.com on Fri, Feb 22, 2002 at 12:28:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:28:14PM -0800, Balbir Singh wrote:
> Check if the alloc_fn and free_fn are not NULL. The caller generally
> ensures that alloc_fn and free_fn are valid. It would not harm
> to check. This makes the checking in mempool_create() more complete.

Rather than leak memory in that case, why not just BUG_ON null 
function pointers so that people know what code is at fault?

		-ben
