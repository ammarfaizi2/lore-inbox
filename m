Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTDKACE (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbTDKACE (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:02:04 -0400
Received: from hera.cwi.nl ([192.16.191.8]:28140 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264091AbTDKACD (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 20:02:03 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 02:13:07 +0200 (MEST)
Message-Id: <UTC200304110013.h3B0D7S24054.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       pbadari@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Roman Zippel <zippel@linux-m68k.org>

    > The conclusion is that the easy way out is to define MAX_NR_DISKS.
    > A different way out, especially when we use 32+32, is to kill this
    > sd_index_bits[] array, and give each disk a new number: replace
    >     index = find_first_zero_bit(sd_index_bits, SD_DISKS);
    > by
    >     index = next_index++;

    Unless you fix all programs which scan /dev/sg*, you better keep 
    the used range dense, so this not really option.

That only holds for the first 256 minors (of the first 8 majors).
Since we want to be completely backwards compatible, nothing
changes there.

But people who want to use new features must update their programs
or at least recompile.

Andries


