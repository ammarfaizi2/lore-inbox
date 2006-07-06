Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWGFDPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWGFDPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWGFDPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:15:03 -0400
Received: from xenotime.net ([66.160.160.81]:60848 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965030AbWGFDPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:15:01 -0400
Date: Wed, 5 Jul 2006 20:17:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: yh@bizmail.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_TARGET
Message-Id: <20060705201746.3438e944.rdunlap@xenotime.net>
In-Reply-To: <4960.58.105.227.226.1152155926.squirrel@58.105.227.226>
References: <4960.58.105.227.226.1152155926.squirrel@58.105.227.226>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 13:18:46 +1000 (EST) yh@bizmail.com.au wrote:

> Hi,
> 
> The O_TARGET is no longer valid in kernel 2.4, what is the replacement of
> following module object in kernel 2.6?
> 
> O_TARGET := NewSerial.o
> 
> obj-y   := new_s_driver.o queue.o
> obj-m   := $(O_TARGET)

You just want a trivial Makefile ?

See Documentation/kbuild/makefiles.txt for more info.

Here is a working trivial example:

#################### begin ###################3
# usage:
# make -C /path/to/kernel/source M=/path/to/source/TARGET/ [modules]

obj-m := TARGET.o

clean-files := *.o *.ko *.mod.c
############# end #######################

M= implies modules, so modules is optional.
I usually use M=$PWD (after cd to TARGET dir).

---
~Randy
