Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbTALVLv>; Sun, 12 Jan 2003 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbTALVLv>; Sun, 12 Jan 2003 16:11:51 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:23168 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S267525AbTALVLu>; Sun, 12 Jan 2003 16:11:50 -0500
Date: Sun, 12 Jan 2003 22:20:34 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030112212034.GA993@mail.muni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz> <20030106144842.GD24714@atrey.karlin.mff.cuni.cz> <20030106151908.GA640@mail.muni.cz> <20030107164028.GC6719@atrey.karlin.mff.cuni.cz> <20030108012133.GA725@mail.muni.cz> <20030110193206.GA14073@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030110193206.GA14073@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 08:32:06PM +0100, Jan Kara wrote:
>   Ok. So I found the bug. Fix was a bit nontrivial (at one path we tried
> to acquire one lock twice) but know it should work. The patch also
> contain fix in ext2 - at some time ext2_setattr was written and call of
> DQUOT_TRANSFER was missing so no quota was being transferred.
>   Please test whether the patch works for you.

Good job. This patch works for me (tested with kernel 2.5.55, successfully
patched with no errors). Thanks a lot.

-- 
Luká¹ Hejtmánek
