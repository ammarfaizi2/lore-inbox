Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSDNNXc>; Sun, 14 Apr 2002 09:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312316AbSDNNXb>; Sun, 14 Apr 2002 09:23:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:56070 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312302AbSDNNXa>;
	Sun, 14 Apr 2002 09:23:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Tue, 09 Apr 2002 23:08:35 +1000."
             <29447.1018357715@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 23:23:16 +1000
Message-ID: <2833.1018790596@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates for kbuild 2.5 at
http://sourceforge.net/project/showfiles.php?group_id=18813

I made the mistake of use the sourceforge fast release system.  Turns
out it creates new releases for each file so there are multiple
'Release 2.0' headings.  Ignore that, they are all part of Release 2.0.

kbuild-2.5-core-5.bz2.  Changes from core-4 to core-5.

  Split config immediately after make *config instead of as a side
  effect of the next target.  Cleaner rules, fewer special cases.
  Add include/sound on include list.
  New command 'select_elsewhere()'.  A complete kludge to work around
  the crc32.o problem in 2.5 kernels.  Selection of CONFIG_CRC32 should
  really be done in CML but CML1 cannot cope, so add a kbuild kludge to
  overcome the incomplete CML data.
  Fix a bug where cached timestamps prevented the detection of some
  config changes.

kbuild-2.5-common-2.4.18-4.bz2.  Changes from common-2.4.18-3 to common-2.4.18-4.

  DocBook tweaks.
  Add dummy dep rule for people who forget that make dep is not required.

New - support for 2.5 kernels, starting with 2.5.8-pre3.  i386 only for
now, ia64 to follow.

kbuild-2.5-common-2.5.8-pre3-1.bz2.

  Built from scratch, there was too much divergence between 2.4.18 and
  2.5.8-pre3 Makefiles.  The result was cross checked against Peter
  Samuelson's patch for 2.5.6pre1, for which much thanks.
    
kbuild-2.5-i386-2.5.8-pre3-1.bz2

  Mainly from i386-2.4.18-1, with updates for i386-2.5.8-pre3.


TODO:

  Add config help to common-2.5.8-pre3-1.  I could not decide where to
  put the config help in 2.5 so I left it until -2.

  Sync common-2.4.19-pre* with common-2.4.18-<n>.  Will be done when
  next 2.4.19-pre* kernel comes out.

  Add 2.4.18-ia64-020410 support.  Already supports 2.4.18-ia64-020226.

  Add 2.5.8-pre3-ia64-020411 support.

  Wait for other arch maintainers to roll patches against kernel 2.5.

  Create Release 2.1 with the latest version of each kernel and arch branch.

  See how stable release 2.1 is then contact Linus.

