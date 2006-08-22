Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWHVVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWHVVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHVVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:13:26 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:42248 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751206AbWHVVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:13:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VR2fRa68ZFqvQEH/0EsIFbybMW73dAWoaWaz6lS/n56t41gdvjPYi6fB6EAOdwVepMF8UZ+jhkTt+9i0gc2ASRQZwNr6u6lG2mtcjrnBPR4y5yiGh773fNUnrGdf0qmn+GQeufjIHVhRVuZxtzzMmTMyCu3fjrqFWFAGDm6qK8Q=
Message-ID: <36e6b2150608221413h3b6baf24lf670a2aed61c0c57@mail.gmail.com>
Date: Wed, 23 Aug 2006 01:13:24 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Jeremy Fitzhardinge" <jeremy@xensource.com>
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060822123850.bdb09717.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
	 <20060822123850.bdb09717.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, Andrew Morton <akpm@osdl.org> wrote:
> I tried to reproduce this with qemu but wasn't able to work out in less
> than sixty seconds (== one attention-span) how to find and use a suitable
> userspace image.  Help.  Could you please suggest where such an image can
> be obtained and how it should be invoked to reproduce this?
>

I made bisection, here is results:

add-efi-e820-memory-mapping-on-x86.patch - GOOD
#
i386-adds-smp_call_function_single-fix.patch
fix-boot-on-efi-32-bit-machines.patch - GOOD
kill-default_ldt.patch - BAD

Wihtout last patch all works ok.
