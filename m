Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUAaQfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 11:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUAaQfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 11:35:38 -0500
Received: from imap.gmx.net ([213.165.64.20]:30135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264919AbUAaQfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 11:35:36 -0500
X-Authenticated: #21910825
Message-ID: <401BD955.3060101@gmx.net>
Date: Sat, 31 Jan 2004 17:35:33 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6.2-rc3] Fix module.c pointer arithmetics
References: <20040131135910.7892A2C0A3@lists.samba.org>
In-Reply-To: <20040131135910.7892A2C0A3@lists.samba.org>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <401BA520.7070204@gmx.net> you write:
> 
>>-	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++) {
>>+	for (i = 0; __start___ksymtab+i*sizeof(struct kernel_symbol) < __stop___ksymtab; i++) {
> 
> 
> Above in this file, there is the declaration:
> 
> extern const struct kernel_symbol __start___ksymtab[];
> 
> What makes you think you need to multiply here?

-ENOCAFFEINE. (Note to self: Never send patches while asleep)
Now that I'm awake again, I feel ashamed.


> Puzzled,
> Rusty.

Sorry for the confusion,
Carl-Daniel.

