Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbTHYNCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbTHYNCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:02:10 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:23777 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S261737AbTHYNCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:02:07 -0400
Message-ID: <3F4A0916.3010906@basmevissen.nl>
Date: Mon, 25 Aug 2003 15:03:18 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel module symbol versioning?
References: <3F461DF4.26519.490C74E@localhost>
In-Reply-To: <3F461DF4.26519.490C74E@localhost>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> Hi,
> 
> I have been reading the book "Linux Device Drivers, 2nd Edition" and have 
> some questions about symbol versioning. In Chapter 11 it mentions that 
> you can use the <linux/modversions.h> header file to compile your module 
> with symbol versions enabled, so that your module will load on multiple 
> kernels and fail if the symbol CRC's do not match. I tested this out on a 
> simple test module, but this module fails to load unless I pass the '-f' 
> flag to insmod (Red Hat 7.3 and 8.0). 
> 
> Is there a way to compile the module so that insmod will only complain if 
> there is a version conflict? Or do you always have to use -f in this case 
> to force the module to load? If you have to do that, will -f still fail 
> to load if the versioned symbols don't match?
> 

Isn't the confict cause here (just) that one is compiled with gcc 2.x 
and the other with gcc 3.x?

In other words, retry compiling this module on one system with the two 
different kernels, as you want to compare kernel source level interface 
  differences and not kernel ABI (Application Binairy Interface IIRC) 
differences.

Regards,

Bas.



