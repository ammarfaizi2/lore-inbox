Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264109AbTICByP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTICByP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:54:15 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:61068 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264109AbTICByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:54:14 -0400
Date: Wed, 03 Sep 2003 10:54:09 +0900
From: NIWA Hideyuki <niwa.hideyuki@soft.fujitsu.com>
Subject: Re: [RFC] Class-based Kernel Resource Management
In-reply-to: <1062186708.15245.832.camel@elinux05.watson.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: niwa.hideyuki@soft.fujitsu.com, ckrm-tech@lists.sourceforge.net
Message-id: <20030903105409.0c341574.niwa.hideyuki@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
References: <1062186708.15245.832.camel@elinux05.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I tried ckrm (Class-based Kernel Resource Management) patch. 
I am very interested in ckrm. 

However, I found the following problems. 

1) Both of ckcpu and ckmem could not be applied at the same time. 

 I corrected the patch by hand. 
 Is it impossible to use both at the same time?

2) When rbcemod of the module is compiled, "ckrm_cpu_change_class" 
   becomes an undeclared symbol. 

 I modified kernel source kernel/class.c and export "ckrm_cpu_change_class": 
        EXPORT_SYMBOL(ckrm_cpu_change_class);

3) The bash process newly executed dies one after another when rbadmin 
   is executed.

 The value of the argument "cls" of the "ckrm_cpu_change_class" 
 function might be NULL. 
 Therefore, the NULL pointer dereference occurs when it 
 starts changing the class of the bash process. 

best regards,
NIWA

