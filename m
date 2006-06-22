Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWFVOch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWFVOch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWFVOch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:32:37 -0400
Received: from rune.pobox.com ([208.210.124.79]:20363 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1161150AbWFVOcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:32:36 -0400
Date: Thu, 22 Jun 2006 09:32:23 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 6/6] cpu_relax(): ptrace.c coding style fix
Message-ID: <20060622143223.GK16029@localdomain>
References: <20060621210046.GF22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621210046.GF22516@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> 
> Fix existing cpu_relax() loop to have proper kernel style.
> 

...

> @@ -182,9 +182,8 @@
>  	if (!write_trylock(&tasklist_lock)) {
>  		local_irq_enable();
>  		task_unlock(task);
> -		do {
> +		while (!write_can_lock(&tasklist_lock))
>  			cpu_relax();
> -		} while (!write_can_lock(&tasklist_lock));

This is a change in behavior, not just style.  (And there is nothing
wrong with the current style.)

