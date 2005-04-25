Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVDYCaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVDYCaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDYCaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:30:46 -0400
Received: from smtpout.mac.com ([17.250.248.83]:51941 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262449AbVDYCak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:30:40 -0400
In-Reply-To: <4ae3c14050424182235f916d7@mail.gmail.com>
References: <4ae3c14050424182235f916d7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cba141443b50f44069d7a92093a0d270@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Ext3+ramdisk journaling problem
Date: Sun, 24 Apr 2005 22:30:35 -0400
To: Xin Zhao <uszhaoxin@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2005, at 21:22, Xin Zhao wrote:
> hi,
>
> I used ramdisk as an ext3 journal and mount ext3 file system with
> option data=journal. It worked fine and speedup the ext3 file system.

Uhh, the whole point of a journal is that when the computer goes down
hard and doesn't have a chance to clean up.  If you put the journal on
a ramdisk, you might as well just mount it as an ext2 filesystem and
be done with it.  Without the journal _on_disk_ you get no data or
filesystem reliability advantages.  If you're after speed, just forgo
the reliability or buy better disks.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


