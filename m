Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWJEBKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWJEBKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWJEBKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:10:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751290AbWJEBKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:10:09 -0400
Date: Wed, 4 Oct 2006 18:10:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reinette Chatre <reinette.chatre@linux.intel.com>
Cc: Joe Korty <joe.korty@ccur.com>,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: separate bitmap parsing for user buffer and
 kernel buffer
Message-Id: <20061004181003.6dae6065.akpm@osdl.org>
In-Reply-To: <200610041756.30528.reinette.chatre@linux.intel.com>
References: <200610041756.30528.reinette.chatre@linux.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 17:56:30 -0700
Reinette Chatre <reinette.chatre@linux.intel.com> wrote:

> +			if (is_user) {
> +				if (__get_user(c, buf++))
> +					return -EFAULT;
> +			}
> +			else
> +				c = *buf++;

Is this actually needed?  __get_user(kernel_address) works OK and (believe
it or not, given all the stuff it involves) boils down to a single instruction.		
