Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269632AbUJGAEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269632AbUJGAEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJGABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:01:15 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20203 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269531AbUJFX5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:57:49 -0400
Subject: Re: __init poisoning for i386, too
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006221854.GA1622@elf.ucw.cz>
References: <20041006221854.GA1622@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1097106995.9693.54.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Oct 2004 09:56:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-10-07 at 08:18, Pavel Machek wrote:
>  		free_page(addr);
> +#ifdef CONFIG_INIT_DEBUG
> +		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
> +#endif

Shouldn't the memset be before the free_page? (Changing freed pages?)

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

