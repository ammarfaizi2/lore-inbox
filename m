Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131341AbRC1O5M>; Wed, 28 Mar 2001 09:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131832AbRC1O5E>; Wed, 28 Mar 2001 09:57:04 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:64406 "EHLO mg03.austin.ibm.com") by vger.kernel.org with ESMTP id <S131286AbRC1O4q>; Wed, 28 Mar 2001 09:56:46 -0500
Message-ID: <3AC1FACF.9DEDA627@austin.ibm.com>
Date: Wed, 28 Mar 2001 08:53:03 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brad Boyer <flar@pants.nu>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
References: <20010328080908.9905E2B54A@marcus.pants.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My turn to chime in.

JFS was designed around a 4K meta-data page size.  It would require some
major re-design to use larger block sizes.  On the other hand, JFS could
take advantage of 64-bit block addresses immediately.  JFS internally
store the block address in 40 bits.  (Sorry, file size & volume size are
both limited to 4 peta-bytes on JFS.)

At the rate that storage hardware and requirements are increasing,
increasing the block size is a short-term solution that is only going to
delay the inevitable requirement for 64-bit block addressability.  There
is a practical limit to a usable block-size.  Someone threw out 64K,
which seems reasonable to me.
-- 
David Kleikamp
IBM Linux Technology Center
