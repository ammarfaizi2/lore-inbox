Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFDAvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFDAvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFDAvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:51:01 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:54167 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261194AbVFDAuz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:50:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BkhkUezR+a2dzulhp02PsGyTf0Zd2HeGjVFUogbC/pvPjS75Tks8yxBFpHSZRtpLrEew7hJylX2CK/oEiyjVGsHJBahYC1/PIKuOj1D9GQPe50xsjSFD9eLjPy5ILzD1h2cZVVCcKkeJkp9RSQqLGQUhgTPeldPUhbTSm37aljk=
Message-ID: <a8447f24050603175061598809@mail.gmail.com>
Date: Fri, 3 Jun 2005 17:50:55 -0700
From: Subrahmanyam Ongole <songole@gmail.com>
Reply-To: Subrahmanyam Ongole <songole@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: x86-64: Kernel with large page size
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When we run our application on AMD Opteron processors, we are seeing a
large number of   L1_AND_L2_DTLB_MISSES. We used oprofile to measure
these numbers.

We wanted to try with a bigger page size and see if we could bring it
down. TLB caches 4k page translations. I don't  know if larger page
size would even help here.

I  changed PAGE_SHIFT to 14 ( 16k page size ) in include/asm/page.h
and recompiled kernel and modules.   It crashed ( PANIC: early
exception ) at the very initial stage of loading the image.

I looked at some of the mailing list archives for any information on
this. I couldn't find anything on this subject . I appreciate any help
on this.

There seem to be two 2-4MB page translations in L1 TLB cache on AMD
machines. Will it be used only when the page size is 2MB or can they
be used with smaller page sizes too.

Thanks for your help.

Regards
Subramanyam
