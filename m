Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUGGCLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUGGCLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 22:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUGGCLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 22:11:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:41408 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264781AbUGGCLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 22:11:17 -0400
Date: Tue, 6 Jul 2004 19:10:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: wli@holomorphy.com, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [LTP] Re: Recent changes in LTP test results
Message-Id: <20040706191009.279aed14.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0407061756170.25528-100000@osdlab.pdx.osdl.net>
References: <20040630073419.GH21066@holomorphy.com>
	<Pine.LNX.4.33.0407061756170.25528-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington <bryce@osdl.org> wrote:
>
> The results listing has been updated.
> 
>      http://developer.osdl.org/bryce/ltp/
> 
>  Briefly:
> 
>  Patch Name           TestReq#    CPU  PASS  FAIL  WARN  BROK
> ...
>  2.6.7-mm6              294691  2-way  7178    46     3     6

Again, these tests do not fail for me, with ltp-full-20040603


vmm:/mnt/hda5/ltp-full-20040603> ./testcases/bin/access03
access03    1  PASS  :  access((char *)-1,R_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    2  PASS  :  access((char *)-1,W_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    3  PASS  :  access((char*)-1,X_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    4  PASS  :  access((char*)-1,F_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    5  PASS  :  access((char*)sbrk(0)+1,R_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    6  PASS  :  access((char*)sbrk(0)+1,W_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    7  PASS  :  access(high_address,X_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    8  PASS  :  access((char*)sbrk(0)+1,F_OK) failed as expected with errno 14 (EFAULT) : Bad address
vmm:/mnt/hda5/ltp-full-20040603> 

Can you please retest with ltp-full-20040603 and, if it still fails,
send me the .config and a description of the system and the compiler
version used to build the kernel?
