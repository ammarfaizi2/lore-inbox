Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269453AbUJSPKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbUJSPKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUJSPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:10:04 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:5049 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S269457AbUJSPJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:09:43 -0400
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.9: performance issues on Via Epia
Date: Tue, 19 Oct 2004 16:04:22 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410191604.22747.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently upgraded from 2.6.8.1 to 2.6.9 (the release, not -final) on my Via 
Epia 5000 router. Now when I transfer files from the machine's HD vsftpd can 
only achieve 3MB/s.

I believe this is some performance problem specifically related to XFS, or 
something specific to the local VM, because if I transfer from an NFS mounted 
directory on the same machine, vsftpd easily achieves the 10MB/s I'm used to.

Top shows something typical to this during transfers from the machine's local 
HD;

Cpu(s):  0.7% us,  9.2% sy,  0.0% ni,  0.3% id, 84.5% wa,  5.3% hi,  0.0% si

Which seems like an awful lot of wait time. Anybody got any suggestions of 
where to start reverting patches? The amount of difference between 2.6.8.1 
and 2.6.9 is quite daunting.

By the way, copying a file locally on the system from the same partition to 
another directory is far more efficient.

[root] 16:02 [~] time cp /var/cache/swapfile here
`/var/cache/swapfile' -> `here'

real    0m37.904s
user    0m0.115s
sys     0m13.033s

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
