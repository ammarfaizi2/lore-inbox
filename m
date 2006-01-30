Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWA3PaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWA3PaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWA3PaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:30:06 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:1312 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932325AbWA3PaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:30:05 -0500
Message-ID: <43DE3164.9010304@sw.ru>
Date: Mon, 30 Jan 2006 18:31:48 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Balbir Singh <balbir@in.ibm.com>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de> <20060130143814.GA25817@in.ibm.com> <20060130145418.GF9181@hasse.suse.de> <43DE2A71.80906@sw.ru> <20060130152515.GH9181@hasse.suse.de>
In-Reply-To: <20060130152515.GH9181@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the fast path (more frequent) is s_prunes == 0.
> 
> sb->s_prunes--;
> if (likely(!sb->s_prunes))
>    wake_up(&sb->s_wait_prunes);
> 
> This is only optimizing a rare case ... and unmounting isn't very time
> critical.
Yeah, you are right. I was thinking about 2 things at the same time and 
was wrong :)

Kirill

