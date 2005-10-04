Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVJDL74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVJDL74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 07:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVJDL74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 07:59:56 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:6092 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbVJDL7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 07:59:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=q3M0qq7krpR7DFCrZuk6DU+V/YG2aK7YFSkMTWZ0VaOH80F5x3MwQILsBpCKC2ZEo4v1XcPXeR/ODDbbCzZUYWbKaZAcM5a+hKp6guyDspMebj8Bsv1/O1lukln7BVaoEKlm/z45NWWNbtCyTYXBrvRPhYWkSHNhTXmoQmGROjs=
Message-ID: <43426EB4.6080703@gmail.com>
Date: Tue, 04 Oct 2005 20:59:48 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Andi.

  In include/asm-x86_64/page.h, __VIRTUAL_MASK_SHIFT is defined as 48 
bits which is the size of virtual address space on current x86_64 
machines as used as such.  OTOH, __PHYSICAL_MASK_SHIFT is defined as 46 
and used as mask shift for physical page address (i.e. physaddr >> 12).

  In addition to being a bit confusing due to similar names but 
different meanings, this means that we assume processors can physically 
address 58 (46 + 12) bits, but both amd64 and IA-32e manuals say that 
current architectural limit is 52 bits and bits 52-62 are reserved in 
all page table entries.  This currently (and in foreseeable future) 
doesn't cause any problem but it's still a bit weird.

  Am I missing something?

  Thanks.

-- 
tejun
