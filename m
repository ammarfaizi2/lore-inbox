Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbQLFSLn>; Wed, 6 Dec 2000 13:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLFSLX>; Wed, 6 Dec 2000 13:11:23 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:23044 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129667AbQLFSLO>; Wed, 6 Dec 2000 13:11:14 -0500
Date: Wed, 6 Dec 2000 18:40:46 +0100
From: Jan Niehusmann <jan@gondor.com>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trashing ext2 with hdparm
Message-ID: <20001206184046.A975@gondor.com>
In-Reply-To: <3A2E767B.D74B24B5@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A2E767B.D74B24B5@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Wed, Dec 06, 2000 at 06:25:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 06:25:15PM +0100, Udo A. Steinberg wrote:
> hdparm -tT /dev/hdb1 does the trick here.
> 
> After that, several files are corrupted, such as /etc/mtab.
> Reboot+fsck fixes the problem, however e2fsck never finds
> any errors in the fs on disk.

I'm currently trying to isolate a bug that is triggered by invalidate_buffers
and leads to in-memory filesystem corruption. 
As hdparm -tT AFAIK calls invalidate_buffers (through BLKFLSBUF), 
this may be related.

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
