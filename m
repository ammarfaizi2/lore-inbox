Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUJSBNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUJSBNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUJSBKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:10:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49131 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268228AbUJSBKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:10:32 -0400
Message-ID: <4174697B.90306@pobox.com>
Date: Mon, 18 Oct 2004 21:10:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Weird... 2.6.9 kills FC2 gcc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following appears in 2.6.9 release kernel, building with stock FC2 
gcc on x86, but does not appear in 2.6.9-final:

>   AS      arch/i386/kernel/vsyscall.o
> cc1: internal compiler error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://bugzilla.redhat.com/bugzilla> for instructions.
> make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
> make: *** [arch/i386/kernel] Error 2



This is 100% reproducible, at the same location (vsyscall), which is 
strange because vsyscall didn't change AFAICS.

I'll build a gcc 3.4.2 without Fedora Core patches and see if the 
behavior persists.

But in the meantime, if anybody else knows what line of code causes this 
segfault, please speak up :)

	Jeff



