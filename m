Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVAGQPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVAGQPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVAGQPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:15:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52699 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261485AbVAGQPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:15:00 -0500
Subject: [RFC] 2.4 and stack reduction patches
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 07:48:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Few of the product groups are running into stack overflow problems
on latest 2.4 distribution releases, especially on z-Series.

While poking thro the 2.4 code, I realized the 2.6 stack reduction
work did not get merged into 2.4. 

Biggest offender seems to be "struct linux_binprm" in do_execve().
Converting structure on the stack to malloc() (like 2.6 does)
solved majority of problems. There are other places, but savings
are smaller. (But after bunch of changes, we were able to reduce
stack by 1K).

I am wondering, if there is any interest in merging stack reduction
patches into 2.4 mainline ? If so, I will rework the patches on
latest 2.4 and submit them. 

Thanks,
Badari

