Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbSJRHDg>; Fri, 18 Oct 2002 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265028AbSJRHCy>; Fri, 18 Oct 2002 03:02:54 -0400
Received: from chunk.voxel.net ([207.99.115.133]:31157 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S265038AbSJRHCY>;
	Fri, 18 Oct 2002 03:02:24 -0400
Date: Fri, 18 Oct 2002 03:08:26 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.43
Message-ID: <20021018070826.GA1110@chunk.voxel.net>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is required to successfully compile 2.5.43 on an ultrasparc.
time.c is missing a header file.


On Tue, Oct 15, 2002 at 08:44:10PM -0700, Linus Torvalds wrote:
> 
> 
> A huge merging frenzy for the feature freeze, although I also spent a few
> days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> those off to the maintainer).
> 
> The most fundamental stuff is probably RCU and oprofile, but there's stuff 
> all over the map here..
> 
> 		Linus
> 
> ------
> 
> Summary of changes from v2.5.42 to v2.5.43
> ============================================
> 
[...]
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="time.c.diff"

--- a/arch/sparc64/kernel/time.c	2002-10-18 02:31:36.000000000 -0400
+++ b/arch/sparc64/kernel/time.c	2002-10-18 02:33:38.000000000 -0400
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/mc146818rtc.h>
 #include <linux/delay.h>
+#include <linux/profile.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>

--TB36FDmn/VVEgNH/--
