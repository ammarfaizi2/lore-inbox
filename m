Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVCPOfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVCPOfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCPOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:34:52 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:61903 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262602AbVCPOdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:33:33 -0500
Message-ID: <423843BA.6010402@ens-lyon.org>
Date: Wed, 16 Mar 2005 15:33:30 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
References: <20050316040654.62881834.akpm@osdl.org>
In-Reply-To: <20050316040654.62881834.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> 
> - fbdev update
> 
> - percfctr updates
> 
> - Lots of ppc32/ppc64 things
> 
> - Broken on some ia64 machines.  We're still working through fallout from
>   the recent pagetable walking consolidation patches.

Hi Andrew,

NTFS does not compile if CONFIG_NTFS_RW is not set.
Patch is attached.

Note I used NTFS_RW as the rest of the NTFS code does.
Don't know whether CONFIG_NTFS_RW preferred.

Regards,

Brice


Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>


--- linux-test/fs/ntfs/attrib.c.old	2005-03-16 15:26:13.000000000 +0100
+++ linux-test/fs/ntfs/attrib.c	2005-03-16 15:27:14.000000000 +0100
@@ -1229,6 +1229,7 @@
  	return 0;
  }

+#ifdef NTFS_RW
  /**
   * ntfs_attr_make_non_resident - convert a resident to a non-resident attribute
   * @ni:		ntfs inode describing the attribute to convert
@@ -1535,6 +1536,7 @@
  		err = -EIO;
  	return err;
  }
+#endif /* NTFS_RW */

  /**
   * ntfs_attr_set - fill (a part of) an attribute with a byte
