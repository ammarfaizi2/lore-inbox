Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTDJXlz (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTDJXlz (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:41:55 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12776 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264258AbTDJXlw (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:41:52 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 01:53:33 +0200 (MEST)
Message-Id: <UTC200304102353.h3ANrXv10792.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Badari Pulavarty <pbadari@us.ibm.com>

    >     I am more worried about names slipping. I atleast hope
    >     to see device names not changing by just doing
    >     rmmod/insmod.
    >
    > But you see, the present sd_index_bits[] gives no such
    > guarantee. In sd_detach a bit is cleared, in sd_attach
    > the first free bit is given out. There is no memory.

    But the disks are probed in the same manner as last time
    (if the disks/controllers are not moved, crashed etc..).
    So we will end up getting same names.

Oh, but if next_index is 0 in the module (or reset by the
init_module code), then also with index = next_index++
things will be the same after rmmod/insmod.

Andries


