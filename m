Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUIHJHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUIHJHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269029AbUIHJHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:07:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:21900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268968AbUIHJFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:05:53 -0400
Date: Wed, 8 Sep 2004 02:04:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard A Nelson <cowboy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
Message-Id: <20040908020402.3823a658.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard A Nelson <cowboy@debian.org> wrote:
>
>  I've received a few of these already - always during *very* heavy disk
>  activity. After the Oops, the disk becomes strangely idle :), and a reboot
>  is required.
> 
>   Unable to handle kernel paging request at virtual address 6b6b6b93
> ...
>   EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI

This might have been caused by a fishy latency-reduction patch.  I today
dropped that patch so could you please test next -mm and let me know?

Alternativety, revert ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/broken-out/journal_clean_checkpoint_list-latency-fix.patch

Thanks.
