Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131680AbQKVW6i>; Wed, 22 Nov 2000 17:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131689AbQKVW62>; Wed, 22 Nov 2000 17:58:28 -0500
Received: from e35.marxmeier.com ([194.64.71.4]:24582 "EHLO e35.marxmeier.com")
        by vger.kernel.org with ESMTP id <S131680AbQKVW6W>;
        Wed, 22 Nov 2000 17:58:22 -0500
Message-ID: <3A1C487C.30BDFE9F@marxmeier.com>
Date: Wed, 22 Nov 2000 23:28:12 +0100
From: Michael Marxmeier <mike@marxmeier.com>
Organization: Marxmeier Software AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: CMA <cma@mclink.it>, linux-kernel@vger.kernel.org
Subject: Re: e2fs performance as function of block size
In-Reply-To: <E13yNlM-0005Q3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I see higher performance with 4K block sizes. I should see higher 
> latency too but have never been able to measure it. Maybe it depends 
> on the file system.
> It certainly depends on the nature of requests

If the files get somewhat bigger (eg. > 1G) having a bigger block
size also greatly reduces the ext2 overhead. Especially fsync() 
used to be really bad on big file but choosing a bigger block
size changed a lot.

If the database used by the original poster is based on 
something like c-isam then (AFAIR) it is in fact using
1k blocks which may explain the better results of 1k block
size. With a 100 MB file size fs management overhead should
not be that visible. 


Michael

-- 
Michael Marxmeier           Marxmeier Software AG
E-Mail: mike@marxmeier.com  Besenbruchstrasse 9
Phone : +49 202 2431440     42285 Wuppertal, Germany
Fax   : +49 202 2431420     http://www.marxmeier.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
