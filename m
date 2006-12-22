Return-Path: <linux-kernel-owner+w=401wt.eu-S1752710AbWLVU6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbWLVU6k (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbWLVU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:58:40 -0500
Received: from [198.99.130.12] ([198.99.130.12]:47260 "EHLO
	saraswathi.solana.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbWLVU6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:58:39 -0500
Date: Fri, 22 Dec 2006 15:53:38 -0500
From: Jeff Dike <jdike@addtoit.com>
To: akpm@osdl.org, Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: parse-boot-parameter-error.patch breaks UML
Message-ID: <20061222205338.GA6525@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the changelog:

	Say a boot parameter is "xxx", if you give a string "xxxy", then the
	boot parameter's corresponding function is executed.

UML has parameters such as "ubda=<filename>" which are matched by
__setup("ubd", ubd_setup), which hits the "error" case this patch now
outlaws.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
