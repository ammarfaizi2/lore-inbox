Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUAFEYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUAFEYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:24:33 -0500
Received: from firewall.conet.cz ([213.175.54.250]:2694 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265336AbUAFEYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:24:32 -0500
Message-ID: <3FFA3871.5060208@conet.cz>
Date: Tue, 06 Jan 2004 05:24:17 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
References: <3FFA30FA.1040602@conet.cz> <200401060412.i064CJtK004302@turing-police.cc.vt.edu>
In-Reply-To: <200401060412.i064CJtK004302@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Unable to handle kernel paging request at virtual address fffffff2
> Hmm.. a -14. ;)
> You did know that getname can return an error, right?

Not untill now - I should had a look a more detailed at code in sys_open. Thanks.


> Poking around in fs/namei.c shows that -14 is 'EFAULT' - most likely
> some bozo did "fd = open(pointer_to_nowhere,....);".  Notice the use
> of IS_ERR(tmp) in sys_open() to guard against this....

I see... (now)...

Why does anybody try to do this? Is there any reason for it? 


-- 
Libor Vanek





