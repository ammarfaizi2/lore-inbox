Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbREYKAW>; Fri, 25 May 2001 06:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbREYKAM>; Fri, 25 May 2001 06:00:12 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:62734 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S263673AbREYJ7x>;
	Fri, 25 May 2001 05:59:53 -0400
Message-ID: <20010525095952.15078.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
Subject: Re: Big-ish SCSI disks
To: gjohnson@research.canon.com.au (Greg Johnson)
Date: Fri, 25 May 101 04:59:52 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010525062236.8CC1837530@zapff.research.canon.com.au> from "Greg Johnson" at May 25, 1 04:22:36 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running stock 2.4.4 on five PCs with these features: ServerWorks
III HE, 2x 933MHz, 4GB RAM, dual-channel sym53c896 (FAST-40 WIDE) SCSI
controller.  One PC has the new 181GB Seagate SCSI drive; another uses a
3ware RAID controller with 4x 40GB IDE (looks like a 160GB SCSI drive).
All is fine with slackware-current.

You might play with "nosmp" and "noapic" kernel params.  When building a
kernel, disable everything including SCSI: work your way up from IDE or
floppy root.  SMP failed on our systems until I dumped the slocket-based
CPUs for Slot 1.  (Still a mystery, that.)
