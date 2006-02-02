Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422923AbWBBECt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbWBBECt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 23:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWBBECt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 23:02:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33961 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422923AbWBBECs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 23:02:48 -0500
Date: Wed, 1 Feb 2006 20:02:03 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH] rcu: undeclared variable used in documentation
Message-ID: <20060202040203.GA27243@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060131010043.GA17021@ev-en.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131010043.GA17021@ev-en.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 03:00:43AM +0200, Baruch Even wrote:
> 
> The RCU documentation uses an fp variable which is not declared in the code
> snippets. Use the new_fp variable instead.

Good catch!!!

							Thanx, Paul

Acked-by: <paulmck@us.ibm.com>
> Signed-Off-By: Baruch Even <baruch@ev-en.org>
> ---
> 
>  Documentation/RCU/whatisRCU.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: htcp-abc/Documentation/RCU/whatisRCU.txt
> ===================================================================
> --- htcp-abc.orig/Documentation/RCU/whatisRCU.txt
> +++ htcp-abc/Documentation/RCU/whatisRCU.txt
> @@ -357,7 +357,7 @@ uses of RCU may be found in listRCU.txt,
>  		struct foo *new_fp;
>  		struct foo *old_fp;
>  
> -		new_fp = kmalloc(sizeof(*fp), GFP_KERNEL);
> +		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
>  		spin_lock(&foo_mutex);
>  		old_fp = gbl_foo;
>  		*new_fp = *old_fp;
> @@ -456,7 +456,7 @@ The foo_update_a() function might then b
>  		struct foo *new_fp;
>  		struct foo *old_fp;
>  
> -		new_fp = kmalloc(sizeof(*fp), GFP_KERNEL);
> +		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
>  		spin_lock(&foo_mutex);
>  		old_fp = gbl_foo;
>  		*new_fp = *old_fp;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
