Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVHJU1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVHJU1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVHJU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:27:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19621
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030253AbVHJU1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:27:45 -0400
Date: Wed, 10 Aug 2005 13:27:44 -0700 (PDT)
Message-Id: <20050810.132744.18577541.davem@davemloft.net>
To: riel@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 2/5] CLOCK-Pro page replacement
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050810200943.068937000@jumble.boston.redhat.com>
References: <20050810200216.644997000@jumble.boston.redhat.com>
	<20050810200943.068937000@jumble.boston.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@redhat.com>
Date: Wed, 10 Aug 2005 16:02:18 -0400

> --- linux-2.6.12-vm.orig/fs/proc/proc_misc.c
> +++ linux-2.6.12-vm/fs/proc/proc_misc.c
> @@ -219,6 +219,20 @@ static struct file_operations fragmentat
>  	.release	= seq_release,
>  };
>  
> +extern struct seq_operations refaults_op;

Please put this in linux/mm.h or similar, so that we'll get proper
type checking of the definition in nonresident.c

Otherwise looks great.
