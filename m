Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWFFJsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFFJsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFFJsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:48:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11916 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932138AbWFFJsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:48:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oNogWLZs0xJlWZhdOmdNjPbwfDH0333n4xuBrsFYWrZUtm+WVgddTztj4scTdYsUgeHPMw/KlmK/YKWZvZi5JxyUdK4ubEzNgWF97rR7UhmO+tVmu7V/CD5MWKXmbFsSV1OMcJMnYvkORkr8o+9YIx4/Dyeq50Mt0lQYfdV6tPk=
Message-ID: <6d6a94c50606060248t1fbe2817mde429f2addbca9d8@mail.gmail.com>
Date: Tue, 6 Jun 2006 17:48:36 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: driver module issue-howto load the some pieces of code into another text section.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm working on the Blackfin-linux platform. For blackfin, Level 1(L1)
memories are located on the chip and are faster than the off-chip
SDRAM. So many users want to load some key driver code into it to
improve the performance.

If user specify a routine running in the L1 memory, there we created
another text section in the ELF file, we called "text_l1" section.

If the driver is built in the kernel, we can load the code to the L1
memory by boot loader. But when the driver is built as a module, if we
still want to load some codes to the L1 memory, we have to change some
common codes, mainly in the file "linux-2.6.x/kernel/module.c".  We
can

1) Use an architecture macro to add the patch code.

2) Use an Kconfig option macro to add the patch code.

I want to know which one is more reasonable and if it's acceptable, thanks.

I really appreciate your any suggestions and comments.

Regards,
-Aubrey
