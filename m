Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129240AbQJ0AYN>; Thu, 26 Oct 2000 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129794AbQJ0AYD>; Thu, 26 Oct 2000 20:24:03 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:19999 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129240AbQJ0AX5>; Thu, 26 Oct 2000 20:23:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: hiren_mehta@agilent.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel build and symbol version problem with RedHat Linux 7 
In-Reply-To: Your message of "Wed, 25 Oct 2000 16:48:05 MDT."
             <FEEBE78C8360D411ACFD00D0B74779718808C2@xsj02.sjs.agilent.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Oct 2000 11:23:40 +1100
Message-ID: <2027.972606220@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2000 16:48:05 -0600, 
hiren_mehta@agilent.com wrote:
>scsi_register    --> scsi_register_R__ver_scsi_register

You have been bitten by the broken Makefiles, time to do a complete
cleanup and start again.

  mv .config ..
  make mrproper (clean is not enough)
  mv ../.config ..
  make oldconfig dep clean vmlinux modules
  Install.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
