Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUFPR0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUFPR0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUFPR0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:26:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56778 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264261AbUFPR0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:26:10 -0400
Message-ID: <40D0829F.7070107@pobox.com>
Date: Wed, 16 Jun 2004 13:25:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takao Indoh <indou.takao@soft.fujitsu.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4][Diskdump]Update patches
References: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
In-Reply-To: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takao Indoh wrote:
>  static inline void tasklet_schedule(struct tasklet_struct *t)
>  {
> +	if(crashdump_mode()) {
> +		diskdump_tasklet_schedule(t);
> +		return;
> +	}
> +


I would suggest

	if (unlikely(crashdump_mode()))

