Return-Path: <linux-kernel-owner+w=401wt.eu-S1030372AbXAETf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbXAETf4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbXAETfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:35:55 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39830 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030372AbXAETfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:35:54 -0500
Date: Fri, 5 Jan 2007 20:36:05 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       kernel@bardioc.dyndns.org
Subject: Re: [PATCH] sysrq: showBlockedTasks is sysrq-X
Message-ID: <20070105193605.GA14592@aepfle.de>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070105110628.5f1e487d.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> SysRq showBlockedTasks is not done via B or T, it's done via X,
> so put that in the Help message.

Weird, who failed to run this command before adding new stuff?!
find * -type f -print0 | xargs -0 env -i grep -nw register_sysrq_key

sysrq x is for xmon, see arch/powerpc/xmon/xmon.c
Better switch the new stuff to 'z' or 'w'
