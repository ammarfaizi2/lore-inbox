Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUATCMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbUATCJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:09:09 -0500
Received: from dp.samba.org ([66.70.73.150]:20902 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265244AbUATCHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:07:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support 
In-reply-to: Your message of "Thu, 15 Jan 2004 12:56:11 BST."
             <20040115115611.GA16266@bytesex.org> 
Date: Tue, 20 Jan 2004 12:55:39 +1100
Message-Id: <20040120020710.8F8F62C280@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040115115611.GA16266@bytesex.org> you write:
> +static int repeat = 1;
> +MODULE_PARM(repeat,"i");
> +MODULE_PARM_DESC(repeat,"auto-repeat for IR keys (default: on)");
> +
> +static int debug = 0;    /* debug level (0,1,2) */
> +MODULE_PARM(debug,"i");

Please replace the MODULE_PARM lines with the modern form:

	module_param(repeat, bool, 0644);
	module_param(debug, int, 0644);

(I'm assuming that it's safe to change repeat and debug on the fly
without any locking.  If not, change to 0444).

For more information, see include/linux/moduleparam.h.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
