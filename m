Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946172AbWJSQZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946172AbWJSQZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946198AbWJSQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:25:24 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:20229 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1946172AbWJSQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:25:23 -0400
Date: Thu, 19 Oct 2006 12:25:20 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Improve the remove sysctl warnings.
In-Reply-To: <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
 <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
 <20061018124415.e45ece22.akpm@osdl.org> <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Eric W. Biederman wrote:

>  	if (msg_count < 5) {
>  		msg_count++;
>  		printk(KERN_INFO
>  			"warning: process `%s' used the removed sysctl "
> -			"system call\n", current->comm);
> +			"system call with ", current->comm);
> +		for (i = 0; i < tmp.nlen; i++)
> +			printk("%d.", name[i]);
> +		printk("\n");
>  	}

We should prolly kill the counter now. Other than that it works for me. 
Thanks Eric!

  - C.

-- 
"There is nothing wrong with your television set. Do not attempt
    to adjust the picture. We are controlling transmission."
                    -- The Outer Limits

