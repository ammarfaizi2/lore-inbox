Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUIKJWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUIKJWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUIKJWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 05:22:22 -0400
Received: from [62.159.120.65] ([62.159.120.65]:64048 "EHLO
	srv-adh-vm-0007.adminsend.de") by vger.kernel.org with ESMTP
	id S268037AbUIKJWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 05:22:03 -0400
Message-ID: <4142C3A1.1010005@adminsend.de>
Date: Sat, 11 Sep 2004 11:21:37 +0200
From: ADH <swing@adminsend.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
References: <2Ca3I-2kY-7@gated-at.bofh.it> <2Cdl9-4Pc-65@gated-at.bofh.it>
In-Reply-To: <2Cdl9-4Pc-65@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm,

looks like probs I had recently on big filesystems under load on a smp 
machine. the only thing different is that I m using samba instead of 
nfs, but behaviour seems the same. On top of that we re encrypting the 
entire filesystems on this machine whicht now holds a total of 9 TB of 
attached storage.

In my observations those errors occure under the following conditions:

- using an smp system
- using applications which concurrently allocating memory in an 
aggressive manner
- freemem is at the lower limit given in vm.min_free_kbytes

Following numerous threats in mailinglists the has been some 
changes/patches for the most current kernels scoping these probs, 
however, if you are bound to a distribution kernel it may help to set 
the mentioned parameter

vm.min_free_kbytes

5 to 10 times bigger than given by default. At least for me it worked 
... no more oops, even under heavy load/backup etc.

---

Independently from this prob, can anyone confirm that there is a prob 
with concurrent allocating memory under load on linux smp systems?!

ciao
andi



