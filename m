Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132937AbRAJJXT>; Wed, 10 Jan 2001 04:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135187AbRAJJXJ>; Wed, 10 Jan 2001 04:23:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8196 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132937AbRAJJW4>;
	Wed, 10 Jan 2001 04:22:56 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
To: mantel@suse.de (Hubert Mantel)
Date: Wed, 10 Jan 2001 06:54:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20010110013755.D13955@suse.de> from "Hubert Mantel" at Jan 10, 2001 01:37:55 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Mantel writes:
> is this part of 2.2.19pre7 really a good idea? Even in 2.4.0 the size
> field is still a short.
>  #define NFS_MAXFHSIZE		64
>  struct nfs_fh {
> -	unsigned short		size;
> +	unsigned int		size;
>  	unsigned char		data[NFS_MAXFHSIZE];
>  };

This is an internal kernel data structure.  Do you know of some program
that breaks as a result of this?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
