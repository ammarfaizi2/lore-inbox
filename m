Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUAYSQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUAYSQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:16:30 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:20452 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265059AbUAYSQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:16:27 -0500
Message-ID: <401407F7.5020102@colorfullife.com>
Date: Sun, 25 Jan 2004 19:16:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: " (Walter Harms)" <WHarms@bfs.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mm/slab.c: linux 2.6.1 fix 2 unguarded kmalloc and a PAGE_SHIFT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walter,

>this fixes catches 2 unguarded kmallocs() and changes a statement so that PAGE_SHIFT \
>>20 causes a warning.  At least sparc64 is prepared for a  PAGE_SHIFT >20.
>  
>
Why should a page shift above 20 generate a warning?

The two unguarded kmallocs are obivously wrong, but I'd prefer to guard 
them with __GFP_NOFAIL.

--
    Manfred

