Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265409AbTLHOGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbTLHOGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:06:39 -0500
Received: from relay.inway.cz ([212.24.128.3]:11403 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S265409AbTLHOGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:06:37 -0500
Message-ID: <3FD4855D.4090203@scssoft.com>
Date: Mon, 08 Dec 2003 15:06:21 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect inode count on reiserfs
References: <3FD47BFC.9020008@scssoft.com> <16340.33245.887082.96412@laputa.namesys.com>
In-Reply-To: <16340.33245.887082.96412@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>reiserfs has no fixed predefined number of inodes on the file
>system. Hence, field f_files of struct statfs (see man 2 statfs) is not
>applicable to this file system. Man page explicitly says:
>
>       Fields that are undefined for a particular file system are
>       set  to  0.
>  
>
duh, I thought that f_files is applicable to reiserfs as well...

>Fix would really be simple: ignore test results if ->f_files is 0 or
>0xffffffff.
>  
>
ok, sorry for the noise... as for the inn2, I have disabled the free 
inode check in innwatch.ctl and it works well

thanks!
Petr

