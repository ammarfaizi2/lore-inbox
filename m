Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWGQS11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWGQS11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWGQS11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:27:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:12933 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751132AbWGQS10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:27:26 -0400
Message-ID: <44BBD688.6070502@namesys.com>
Date: Mon, 17 Jul 2006 11:27:20 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Jeffrey Mahoney <jeffm@suse.com>, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com>            <44BAFDC3.7020301@namesys.com> <200607171808.k6HI8kjL018161@turing-police.cc.vt.edu>
In-Reply-To: <200607171808.k6HI8kjL018161@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Sun, 16 Jul 2006 20:02:27 PDT, Hans Reiser said:
>
>  
>
>>Create a mountpoint which knows how to resolve a/b without using a
>>"directory".
>>    
>>
>
>And said mountpoint gets past the '/' interpretation in the VFS, how, exactly?
>
>fs/namei.c, do_path_lookup() does magic on a '/' on about the 3rd line.
>So you're going to get handed 'a'.
>  
>
It does not need to be so complex actually,  Just create a plain old
parent directory just like every other parent directory in procfs.
