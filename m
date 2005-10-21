Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVJUSHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVJUSHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVJUSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:07:03 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:13977 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965059AbVJUSHA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:07:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dvXeU/QGhWytUhNitCue0j/PObHKR6I3PtdmBifSu4OG0jysXpk3cV8AOXOMwsaaMwnAzeVI33TVBpvsLrNSnsWcOCCqcmMZhyGmxQvZWdM3g7uRzBcDKcQwf0XGWeCJizC9HsgH2uPNfoCBH+CfI0DSA0jRKTsBLKEvhXVCwa0=
Message-ID: <94e67edf0510211106m4b8f7fa4k5085531e278ea9d3@mail.gmail.com>
Date: Fri, 21 Oct 2005 14:06:59 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
To: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: XIP kernel - bss address location issue
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a montavista XIP kernel running on ARM and my kernel will be in
the flash. Since its XIP, I know that the ".text" portion of the
kernel will be executed from flash but that ".data" needs to be placed
in SDRAM. Now my question is - based on what offset this data will be
placed?

My SDRAM physicall address starts at 3000_0000 and flash starts at
0100_0000. when i allocated a global variable in the kernel module and
when i try to check its actually physical address using virt_to_phys,
its giving me the address in the range of 0100_0000 ~ 0600_0000 which
is my flash (the PAGE_OFFSET doesn't work in case of XIP).

Can you please help in knowing the physical address of my .data
portion in this situation.

Thanks
Shree
