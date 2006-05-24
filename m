Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWEXAsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWEXAsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWEXAst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:48:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932451AbWEXAss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:48:48 -0400
Date: Tue, 23 May 2006 17:48:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Message-Id: <20060523174827.0ce1943b.akpm@osdl.org>
In-Reply-To: <20060524002012.19403.50151.stgit@gitlost.site>
References: <20060524001653.19403.31396.stgit@gitlost.site>
	<20060524002012.19403.50151.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> +	for_each_cpu(i)

That's about to be deleted.  Please use for_each_possible_cpu().

That's if for_each_possible_cpu() is appropriate.  Perhaps it should be
using for_each_present_cpu(), or for_each_online_cpu().  That's why
for_each_cpu() is going away - to make people think about such things..

