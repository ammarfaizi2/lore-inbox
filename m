Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSKLU2x>; Tue, 12 Nov 2002 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbSKLU2x>; Tue, 12 Nov 2002 15:28:53 -0500
Received: from head.linpro.no ([80.232.36.1]:22666 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id <S266927AbSKLU2v>;
	Tue, 12 Nov 2002 15:28:51 -0500
To: linux-kernel@vger.kernel.org
Subject: iostats broken for devices with major number > DK_MAX_DISK (16)
From: Per Andreas Buer <perbu@linpro.no>
Organization: Linpro AS
Date: 12 Nov 2002 21:35:38 +0100
Message-ID: <PERBUMSGID-ul64ramh6g5.fsf@nfsd.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18Bhl4-0003Ej-00*6LN.BWpPtPE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the intrusion. I noticed iostats didn't display statistics for
devices on Mylex RAID constrollers. Det statistics are completely
missing in /proc/stat. The reason seems to be an assumption that disks
have major numbers which are below 16
(http://lxr.linux.no/source/include/linux/kernel_stat.h#L15) which is
used by http://lxr.linux.no/source/fs/proc/proc_misc.c#L344.

Devices on Mylex-controllers have major number 48. Would it break
anything if DK_MAX_MAJOR if set higher (e.g. 64)?

AFAIK this goes for both 2.4 and the 2.5 series.



-- 
Per Andreas Buer
