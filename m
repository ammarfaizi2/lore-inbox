Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbULCFKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbULCFKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 00:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbULCFKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 00:10:06 -0500
Received: from mail.aei.ca ([206.123.6.14]:42189 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261993AbULCFKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 00:10:01 -0500
Subject: (kernel 2.6.9) insmod: -1 Invalid module format
From: Stephane Coulombe Bisson <stephcoul@aei.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1102051062.5992.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Dec 2004 00:17:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm new to Linux module dev, I copied a very simple module from a book
(http://lwn.net/Kernel/LDD2/ch02.lwn) and I can't insert it into the
kernel.

I found hundreds of bug reports about it on google without any solution.
I must be doing something wrong... 

/*----------mymodule.c-----------*/
#define MODULE
#include <linux/module.h>
int init_module(void)  
{ printk("<1>Hello, world\n"); return 0; }
void cleanup_module(void) 
{ printk("<1>Goodbye cruel world\n"); }
/*----------EOF-----------*/

# gcc -c mymodule.c
# insmod mymodule.o
insmod: error inserting 'mymodule.o': -1 Invalid module format


Thanks a lot

steph

