Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTDJXVv (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTDJXVv (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:21:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57315 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264237AbTDJXVt (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:21:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 01:33:29 +0200 (MEST)
Message-Id: <UTC200304102333.h3ANXTi28340.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Badari Pulavarty <pbadari@us.ibm.com>

    > Then we don't know which disks have disappeared. Pity.
    > If the number space is infinite then
    >    index = next_index++;
    > gives a new number each time we need one.

    Yes !! I agree. I am not worried about running out them.
    I am more worried about names slipping. I atleast hope
    to see device names not changing by just doing
    rmmod/insmod.

But you see, the present sd_index_bits[] gives no such
guarantee. In sd_detach a bit is cleared, in sd_attach
the first free bit is given out. There is no memory.

Andries
