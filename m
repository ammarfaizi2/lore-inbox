Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262909AbREWAHV>; Tue, 22 May 2001 20:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbREWAHO>; Tue, 22 May 2001 20:07:14 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31395 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262909AbREWAG5>;
	Tue, 22 May 2001 20:06:57 -0400
Message-ID: <3B0AFEFE.1198871C@mandrakesoft.com>
Date: Tue, 22 May 2001 20:06:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.GSO.4.21.0105221909001.17373-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Do we really want a separate queue for each partition? I'd rather have
> disk_struct created when driver sees the disk and list of partitions
> (possibly represented by struct block_device) anchored in disk_struct
> and populated by grok_partitions().

Alan recently straightened me out with "EVMS/LVM is partitions done
right"

so... why not implement partitions as simply doing block remaps to the
lower level device?  That's what EVMS/LVM/md are doing already.

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
