Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUAFMgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUAFMgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:36:24 -0500
Received: from firewall.conet.cz ([213.175.54.250]:31629 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261957AbUAFMgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:36:23 -0500
Message-ID: <3FFAAB91.6090207@conet.cz>
Date: Tue, 06 Jan 2004 13:35:29 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
References: <1aQy3-2y1-7@gated-at.bofh.it> <m3znd139ur.fsf@averell.firstfloor.org>
In-Reply-To: <m3znd139ur.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Libor Vanek <libor@conet.cz> writes:
>  
>
>>...
>>asmlinkage long sys_open(const char __user * filename, int flags, int mode)
>>{
>>        char * tmp;
>>        int fd, error;
>>	char tmp_path[PATH_MAX],tmp2_path[PATH_MAX];
>>    
>>
>PATH_MAX is 4096. The i386 stack is only 6k. You already overflowed it.
>You're lucky if your machine only panics, much worse things can happen
>with kernel stack overflows.
>  
>
OK - what's correct implementation? Do a "char * tmp_path" and kmalloc it?


-- 

Libor Vanek





