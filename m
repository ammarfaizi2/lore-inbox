Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281951AbRKUSc6>; Wed, 21 Nov 2001 13:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281943AbRKUScu>; Wed, 21 Nov 2001 13:32:50 -0500
Received: from ns.suse.de ([213.95.15.193]:52752 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281945AbRKUSch>;
	Wed, 21 Nov 2001 13:32:37 -0500
To: "Alex Adriaanse" <alex_a@caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working
In-Reply-To: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2001 07:08:13 +0100
In-Reply-To: "Alex Adriaanse"'s message of "14 Nov 2001 23:19:07 +0100"
Message-ID: <p737kss7eia.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alex Adriaanse" <alex_a@caltech.edu> writes:
> = 4095
> write(1, "\0", 1)                       = -1 EFBIG (File too large)
> --- SIGXFSZ (File size limit exceeded) ---
> +++ killed by SIGXFSZ +++
> 
> I'm doing this on a ReiserFS filesystem, but trying it on an ext2 partition
> yields the same results.
> 
> Any suggestions?

ulimit -f unlimited.

SIGXFSZ means you exceeded your quota. Somehow you managed to set your 
file size quotas to 2GB. Set them to unlimited instead. It could be caused
by same PAM module; e.g. pam_limits, check /etc/security/*



-Andi
