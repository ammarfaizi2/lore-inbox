Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313576AbSDMIBd>; Sat, 13 Apr 2002 04:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313578AbSDMIBc>; Sat, 13 Apr 2002 04:01:32 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:3344 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313576AbSDMIBc>;
	Sat, 13 Apr 2002 04:01:32 -0400
Date: Sat, 13 Apr 2002 17:01:14 +0900 (JST)
Message-Id: <20020413.170114.132440284.taka@valinux.co.jp>
To: ak@suse.de
Cc: lk@tantalophile.demon.co.uk, davem@redhat.com,
        linux-kernel@vger.kernel.org, "Andrew Theurer" <habanero@us.ibm.com>
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020413083952.A32648@wotan.suse.de>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks to Andrew Theurer for his help.
He posted the result of testing my patches on nfs@lists.sourceforge.net
list, we can get a great performance.

> I tried the patch with great performance improvement!   I ran my nfs read
> test (48 clients read 200 MB file from one 4-way SMP NFS server) and
> compared your patches to regular 2.5.7.  Regular 2.5.7 resulted in 87 MB/sec
> with 100% CPU utilization.  Your patch resulted 130 MB/sec with 82% CPU
> utilization!  This is very good!  I took profiles, and as expected,
> csum_copy and file_read_actor were gone with the patch.  Sar reported nearly
> 40 MB/sec per gigabit adapter (there are 4) during the test.  That is the
> most I have seen so far.  Soon I will be doing some lock analysis to make
> sure we don't have any locking problems.  Also, I will see if there is
> anyone here at IBM LTC that can assist with your development of zerocopy on
> UDP.  Thanks for the patch!
> 
> Andrew Theurer

