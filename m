Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVKPRg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVKPRg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKPRg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:36:26 -0500
Received: from kanga.kvack.org ([66.96.29.28]:5760 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965096AbVKPRgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:36:25 -0500
Date: Wed, 16 Nov 2005 12:33:58 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Lee <linuxtwidler@gmail.com>
Cc: linux-kernel@vger.kernel.org, pageexec@freemail.hu
Subject: Re: 4k stack overflow and stack traces
Message-ID: <20051116173358.GA982@kvack.org>
References: <20051110083525.6cfe6f35@localhost> <20051115202827.GC31988@kvack.org> <20051115164005.0d7f5baf@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115164005.0d7f5baf@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 04:40:05PM -0600, Lee wrote:
> see attached for filesystems, devices, current kernel build config
> 
> do you advise doing a make checkstack before or after the patch that you speak of making?

Yes please, that will give us all the datapoints from your particular 
gcc version, config and modules.

> I also have iptables configured with nat for local connections enabled
> 
> i am also using ethernet bridge (intended for apps like pearpc and qemu, 
> which i use very infrequently).  

Hmmm, does it trigger on any particular network traffic?  I'm wondering 
if one of the masquerading modules you're using happens to eat just 
enough stack when mixed with the bridging configuration.

		-ben
