Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRIYVo1>; Tue, 25 Sep 2001 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270314AbRIYVoN>; Tue, 25 Sep 2001 17:44:13 -0400
Received: from adsl-64-168-2-131.dsl.scrm01.pacbell.net ([64.168.2.131]:54534
	"EHLO snuffy.c0nfusion.org") by vger.kernel.org with ESMTP
	id <S269326AbRIYVnw>; Tue, 25 Sep 2001 17:43:52 -0400
Subject: Solution to lockups with Via chipset and some 3D cards
From: Josh Green <jgreen@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 25 Sep 2001 14:46:10 -0700
Message-Id: <1001454371.1442.22.camel@freakysheik>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing lockups with my NVidia TNT card, the NVidia
drivers and Linux 2.4.x. I've done quite a lot of testing with different
settings with the NVidia driver, with similar instability problems. I
was discussing this problem on a mailing list and someone asked me if I
had an AMD processor with a Via chipset. He mentioned that Win2k has a
patch, which he experienced lockups with his video card until he applied
it. He obtained some technical details of this patch which are below:

The following workaround for this issue prevents Memory Manager from
using the processor's Page Size Extension feature and may affect the
performance of some programs, depending on the paging behavior. This
registry value also limits non-paged pool to a maximum of 128 megabytes
(MB) instead of 256 MB.

Taken from MS Knowledge base article Q270715


The problem, in the case of win2k, is that memory that has been
allocated by the video adapter driver is being corrupted.

How would something like this be applied to the Linux kernel? Does it
sound like a valid solution? It was mentioned that this problem also
occurs for the Matrox G400 card as well. I can supply more information
if necessary, I just wanted to probe the LKML first as to where to go
from here.

* Please CC me as I'm not on the list.

-- 
    Josh Green
    Smurf Sound Font Editor (http://smurf.sourceforge.net)

