Return-Path: <linux-kernel-owner+w=401wt.eu-S965095AbXADWNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXADWNo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbXADWNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:13:44 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58364 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbXADWNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:13:43 -0500
Date: Thu, 4 Jan 2007 14:03:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Frederik Deweerdt <deweerdt@free.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 8/8] user ns: implement user ns unshare
Message-Id: <20070104140316.e9d42dc3.akpm@osdl.org>
In-Reply-To: <20070104194351.GB17506@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com>
	<20070104181310.GI11377@sergelap.austin.ibm.com>
	<20070104190700.GB17863@slug>
	<20070104194351.GB17506@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 13:43:51 -0600
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

I was just about to commit this lot then I discovered vast amounts of
eight-spaces-where-there-should-be-tabs.  Returned to sender for complete
repair, please.

>  
> +bad_unshare_cleanup_user:
> +	if (new_user)
> +		put_user_ns(new_user);

put_user_ns(NULL) is legal.

> +       for(n = 0; n < UIDHASH_SZ; ++n)
             ^ space here


