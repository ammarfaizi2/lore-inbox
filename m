Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbTC0F3B>; Thu, 27 Mar 2003 00:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbTC0F3B>; Thu, 27 Mar 2003 00:29:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262885AbTC0F3A>;
	Thu, 27 Mar 2003 00:29:00 -0500
Message-ID: <32826.4.64.238.61.1048743612.squirrel@webmail.osdl.org>
Date: Wed, 26 Mar 2003 21:40:12 -0800 (PST)
Subject: Re: nit picking UDF
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <david+cert@blue-labs.org>
In-Reply-To: <3E82866A.1000704@blue-labs.org>
References: <3E82866A.1000704@blue-labs.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: (supports S0 S1 S4 S4bios S5)
> You didn't specify the type of your ufs filesystem
>
> mount -t ufs -o
> ufstype=sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...
>
>  >>>WARNING<<< Wrong ufstype may corrupt your filesystem, default is
> ufstype=old
> ufs_read_super: bad magic number
> UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session:
> CDROMMULTISESSION not supported: rc=-25
> UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
> UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048  byte
> sectors)
> UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte
> 32768. Assuming open disc. Skipping validity check
> UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block
> 256, tag 18 != 256
> UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block found
> UDF-fs: No partition found (1)
> found reiserfs format "3.6" with standard journal
>
> Is all this blurbage necessary?  I don't even have a disc in the 'rom  drive
> because it causes the kernel to lock up hard on bootup if I do.   Right at
> the moment, the 'rom isn't even plugged in.

Is this with 2.5.66?

I also get an oops during boot on 2.5.66 if I have
  hdc=ide-scsi
on the kernel boot command line.  I have to remove it to boot 2.5.66.
I don't mind editing lilo.conf, but the oops shouldn't be what makes
me edit it.

~Randy



