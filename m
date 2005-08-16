Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVHPJs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVHPJs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHPJs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:48:59 -0400
Received: from [212.45.14.9] ([212.45.14.9]:22011 "EHLO ari.home")
	by vger.kernel.org with ESMTP id S965168AbVHPJs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:48:59 -0400
Date: Tue, 16 Aug 2005 13:48:39 +0400 (MSD)
From: "Lev A. Melnikovsky" <leva@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: atime on devices
Message-ID: <Pine.LNX.4.62.0508161209540.6795@nev.ubzr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is sometimes useful to know device access time. Things that I have in 
mind are the software-based hard disk inactivity spindown (some brain 
damaged IDE drives fail to follow "hdparm -S" if the argument is longer 
than 1/2 hour) and sound card muting if it is not touched for a while. 
Notebook users might want to powerdown their network cards after 
inactivity as well.

I wonder if such functionality is already available or is planned to be 
available some time soon?

Earlier discussions I found in the list mention also atime of tty, mouse 
and other human interface device (but "access" meaning is somewhat 
different).

Thanks
-L.

P.S. For my own purposes of the disk spindown I'm using an ad-hoc patch 
(which I wrote as a proof of the concept while using late 2.2 kernels, it 
is still functional in 2.4.30, never had time to rewrite it properly) to 
ide-disk.c, so that it exports the last access time as 
/proc/ide/hdX/last_access. Keeping atime attribute along with device files 
themselves seems more logical, but might cause side effects...
