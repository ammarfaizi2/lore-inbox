Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWDQOvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWDQOvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWDQOvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:51:00 -0400
Received: from canuck.infradead.org ([205.233.218.70]:62158 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751052AbWDQOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:50:59 -0400
Subject: Re: [PATCH] Remove unnecessary kmalloc/kfree calls in mtdchar
From: David Woodhouse <dwmw2@infradead.org>
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: Josh Boyer <jwboyer@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <82ecf08e0604170619i582bfa19r19a3da0d7d0904b1@mail.gmail.com>
References: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
	 <625fc13d0604170506n53147772vec944cdd7f2daef7@mail.gmail.com>
	 <82ecf08e0604170619i582bfa19r19a3da0d7d0904b1@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 15:50:34 +0100
Message-Id: <1145285434.13200.9.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 10:19 -0300, Thiago Galesi wrote:
> 
> +       if (!kbuf) {
> +               printk("kmalloc is null\n");
> +               return -ENOMEM;
> +       }

Don't printk -- especially without a priority. Either just bail out with
-ENOMEM or try a smaller size.

-- 
dwmw2

