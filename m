Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132632AbRAVQSA>; Mon, 22 Jan 2001 11:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAVQRv>; Mon, 22 Jan 2001 11:17:51 -0500
Received: from postfix.conectiva.com.br ([200.250.58.155]:43787 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132441AbRAVQRf>; Mon, 22 Jan 2001 11:17:35 -0500
Message-ID: <3A6C5D12.99704689@conectiva.com.br>
Date: Mon, 22 Jan 2001 14:17:22 -0200
From: Andrew Clausen <clausen@conectiva.com.br>
Organization: Conectiva
X-Mailer: Mozilla 4.76 [pt_BR] (X11; U; Linux 2.2.17-14cl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Partition IDs in the New World TM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have roughly 10 different types of partition tables.  We hate
them, but it looks like they won't be going away for a long time.

Partition IDs seem to create a lot of confusion.  For example,
most people use 0x83 for both ext2 and reiserfs, on msdos
partition tables.  People use "Apple_UNIX_SVR2" for ext2 on
Mac, etc.

Linux doesn't really use partition IDs.  Well, not entirely
true... it's used on Mac's as a heuristic, for finding swap
devices, etc. - but I think this unnecessary.

LVM also uses it, but I also think it's unnecessary.

So, can anyone remember why we have partition IDs?  (as opposed
to just probing for signatures on the fs)  If new partition table
types come out (which is happening, believe it or not...), how
should Linux/fdisk/parted handle IDs?  Should we have one Linux
type, that we use for everything?  Should we have one type for each
TYPE of data (file system, swap, logical volume physical device, etc.)?

Tchau,
Andrew Clausen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
