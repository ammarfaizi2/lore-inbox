Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUGBMfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUGBMfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUGBMfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:35:09 -0400
Received: from smtpout.azz.ru ([81.176.67.34]:7096 "HELO mailserver.azz.ru")
	by vger.kernel.org with SMTP id S264401AbUGBMfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:35:03 -0400
Message-ID: <40E556E5.90708@vlnb.net>
Date: Fri, 02 Jul 2004 16:36:53 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dependant modules question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need some assistance with the kernel build system. It looks like this 
topic is not covered anywhere, at least I didn't find anything.

I have two modules, A and B, where B is dependant from A, i.e. uses some 
exported from it symbols. Both modules are built outside of the kernel 
tree.

With A everything is fine, it's compiled and installed with other kernel 
modules in /lib/modules/2.6.7/extra.

Then module B is built. Here I have a problem. Module A is not listed as 
the module from which B depends in .mod.c file, therefore there are 
"Undefined symbols" warnings and it is impossible to load B, even though 
A is loaded.

So, the question is: what should I do to make A be seen as exporting 
some symbols by the kernel and its build system?

The kernel is 2.4.7, EXPORT_SYMBOL() used in A as required.

Thanks,
Vlad
