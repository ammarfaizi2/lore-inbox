Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRDJWde>; Tue, 10 Apr 2001 18:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRDJWd2>; Tue, 10 Apr 2001 18:33:28 -0400
Received: from smtp5.xs4all.nl ([194.109.6.49]:51186 "EHLO smtp5.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132418AbRDJWdJ>;
	Tue, 10 Apr 2001 18:33:09 -0400
Date: Wed, 11 Apr 2001 00:33:07 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: vfat read problem with 2.4.x
Message-ID: <20010411003307.A17911@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Marks-The-Spot: xxxxxxxxxx
X-Machine-info: BSD/OS xs4.xs4all.nl 4.0 i386
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encountered a problem with 2.4 kernels today.

Decompressing a 60+ Mb file with bzip2, residing on a vfat partition, gave
errors reporting that the archive was corrupt.
When I rebooted into windows and ran scandisk it couldn't find any problem
with the partition. That made me suspicious...
I rebooted into an leftover 2.2.18, ran "bunzip -t" on the file, and all was
fine. Rebooted back into 2.4.3, bunzip gave errors. Tried 2.4.2 (had an image
of that left around as well), errors too.

I copied the file (in 2.2.18) to my ext2 partition, tested it with bzip2 in
the 2.4 kernels and all was fine - so it is most likely a vfat related
problem.
Also, the file was written to the vfat partition in 2.4.2, so writing may not
even be affected by this possible bug.

Regards,

Filip

-- 
Sometimes it pays to stay in bed on Monday, rather than spending the rest of
the week debugging Monday's code.
	-- Dan Salomon
