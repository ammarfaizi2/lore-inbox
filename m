Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUJBNFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUJBNFU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUJBNFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:05:20 -0400
Received: from asplinux.ru ([195.133.213.194]:48906 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S265909AbUJBNFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:05:13 -0400
Message-ID: <415EAA98.3010108@sw.ru>
Date: Sat, 02 Oct 2004 17:18:16 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] detach_pid(): restore optimization
References: <415D3DD4.E440AB5B@tv-sign.ru>
In-Reply-To: <415D3DD4.E440AB5B@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can sign off both patches. They look ok.

Signed-off-By: Kirill Korotaev <dev@sw.ru>

> Kirill's kernel/pid.c rework broke optimization logic in detach_pid().
> Non zero return from __detach_pid() was used to indicate, that this pid
> can probably be freed. Current version always (modulo idle threads)
> return non zero value, thus resulting in unneccesary pid_hash scanning.
> 
> Also, uninlining __detach_pid() reduces pid.o text size from 2492 to 1600
> bytes.
> 
> Oleg.

[...]

Kirill


