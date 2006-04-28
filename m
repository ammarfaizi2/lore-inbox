Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWD1Hk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWD1Hk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWD1Hk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:40:59 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:8465 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030302AbWD1Hk6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:40:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OW6YAD5YkTZAtQQCg6wVskuet4rvUfocWklTj1qjoK4auABv+4Ixg9AxPeDAatDXhSHIIp2bY+Mn8rSw/EFMkH8aD6OJ03KgXH4GRZVrcLnIW2LvOuAR5MnYsq7eODTfQy6zQcqit15HObHjHHWOuzZkq2fId+qNk/krK94HBiA=
Message-ID: <aec7e5c30604280040p60cc7c7dqc6fb6fbdd9506a6b@mail.gmail.com>
Date: Fri, 28 Apr 2006 16:40:57 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
Subject: i386 and PAE: pud_present()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

In file include/asm-i386/pgtable-3level.h:

On i386 with PAE enabled, shouldn't pud_present() return (pud_val(pud)
& _PAGE_PRESENT) instead of constant 1?

Today pud_present() returns constant 1 regardless of PAE or not. This
looks wrong to me, but maybe I'm misunderstanding how to fold the page
tables... =)

Thanks,

/ magnus
