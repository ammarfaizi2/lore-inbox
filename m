Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVHHDu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVHHDu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 23:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVHHDu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 23:50:57 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:10268 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbVHHDu5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 23:50:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TnlU01K8i+8DPLQguwXVoworlXL7ffL3nuQo8WrD9F9iJv+VMVDyCw7zwpvo7CRykn9NQZjjKqLe95pbDaBc/rqliQHrfTCAEig5UouzroKrGbQsP6bqTJt7KEMLO8jeYmvDme8dw526qR6831t7rPgfXaT0VwTPvNT4HUGq5KM=
Message-ID: <1e62d137050807205047daf9e0@mail.gmail.com>
Date: Mon, 8 Aug 2005 08:50:54 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
Cc: nhorman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I m facing a problem in RHEL3 (2.4.21-5.ELsmp) kernel while using
kmap_atomic on the pages reserved at the boot time !!!!

At the boot time I reserved pages above 2GB for later use by my module
..... And when I was using those reserved pages through kmap_atomic
system hangs; although kmap_atomic successfully returns me the virtual
address but when I use that virtual address like in memcpy the system
hangs .....

I m unable to findout why it is happening in RHEL3 kernel !!!! Plz
help me in this regard ....

-- 
Fawad Lateef


P.S.

My memory reservation and later using that memory through kmap_atomic
works well on the kernels other than RHEL3 2.4.21-e.ELsmp  
.............. the page reservation was done in the
arch/i386/mm/init.c file in function one_highpage_init ...... I have
Machine with 16GB RAM and 2 - Xeon 2.4GHz Processors .....
