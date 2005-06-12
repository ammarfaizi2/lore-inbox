Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVFLJ1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVFLJ1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVFLJ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:27:26 -0400
Received: from web33308.mail.mud.yahoo.com ([68.142.206.123]:30134 "HELO
	web33308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261923AbVFLJZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:25:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mVcFcJjFgi75lTkEqxSg95uqbIoR47KJZtztVN5ILrwCbScF0H+oYkBs7VVP8ERXnCeHk0OIaP9Y+D7bhWPuIPYdE8sOLybPPc+g2WhyRaYMjI76ZH2CvYh414q8zoRfgc4ZYAIM3tcW5bmfoZXsTuxWPNCKxgQsEHFQAPaF69k=  ;
Message-ID: <20050612092544.25913.qmail@web33308.mail.mud.yahoo.com>
Date: Sun, 12 Jun 2005 02:25:44 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: 2.6: problem with module tainting the kernel
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050610201812.037b6a01.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Randy and everyone who replied.
Yes, I am using SuSE kernel.
On building the module it successfully generates
hello.ko.
Here is the message I get on doing a insmod of
hello.ko:

"Jun 12 14:47:56 myhost kernel: hello: unsupported
module, tainting kernel."

Here is the code

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/version.h>
#include <linux/vermagic.h>

static int __init hello_init (void)
{
        printk("module hello loading");
        return 0;
}

static void __exit hello_exit (void)
{
        printk("module hello exiting");
}

module_init(hello_init);
module_exit(hello_exit);
MODULE_LICENSE ("GPL");

--- randy_dunlap <rdunlap@xenotime.net> wrote:

> On Fri, 10 Jun 2005 08:24:50 -0700 (PDT) li nux
> wrote:
> 
> | In 2.6 kernels how to assure that on inserting our
> own
> | module, it doesn't throw the warning:
> | 
> | "unsupported module, tainting kernel"
> 
> That string is not in the kernel source code that I
> can see.
> Be more precise, please.
> 
> 
> | what tainting depends on apart from the license
> string ?
> 
> load:
> 
> - CONFIG_MODVERSIONS is set but some symbol does not
> have
>   version info
> 
> - a license that is not GPL-compatible
> 
> - no version magic info for the module
> 
> unload:
> 
> - forcefully unloading a module
> 
> ---
> ~Randy
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
