Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTEEEeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTEEEeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:34:25 -0400
Received: from dp.samba.org ([66.70.73.150]:38353 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261907AbTEEEeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:34:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bob Miller <rem@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.68] Convert elan-104nc to remove check_region(). 
In-reply-to: Your message of "Fri, 02 May 2003 13:42:07 MST."
             <20030502204207.GB25713@doc.pdx.osdl.net> 
Date: Mon, 05 May 2003 14:38:02 +1000
Message-Id: <20030505044653.D296B2C255@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030502204207.GB25713@doc.pdx.osdl.net> you write:
> Moved the request_region() call to replace check_region() and adds
> release_region()'s in the error paths that occure before the old
> call to request_region().

>  NOTE: This patch just updates comments.

Actually. It doesn't.

And why this:

> @@ -227,14 +227,14 @@
>  	}
>  
>  	iounmap((void *)iomapadr);
> -	release_region(PAGE_IO,PAGE_IO_SIZE);
> +	/* release_region(PAGE_IO,PAGE_IO_SIZE); */
>  }

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
