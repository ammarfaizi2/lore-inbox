Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292534AbSBPVJ7>; Sat, 16 Feb 2002 16:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292535AbSBPVJj>; Sat, 16 Feb 2002 16:09:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:19731 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292534AbSBPVJd>; Sat, 16 Feb 2002 16:09:33 -0500
Message-ID: <3C6ECA71.8010103@evision-ventures.com>
Date: Sat, 16 Feb 2002 22:09:05 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] size-in-bytes
In-Reply-To: <UTC200202161609.QAA31164.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>
> /*
>+ * blk_size_in_bytes contains the size of all block-devices in bytes
>+ * (blk_size has too low a resolution, since we really need the size
>+ * in 512 byte sectors, and fails on devices > 2 TB)
>+ *
>+ * blk_size_in_bytes[MAJOR][MINOR]
>+ *
>+ * if (!blk_size_in_bytes[MAJOR]) then no minor size checking is done.
>+ */
>+loff_t * blk_size_in_bytes[MAX_BLKDEV];
>+
>+/*
>
Please pin it up the block device structure not to just another 
 arbitrary global array.


