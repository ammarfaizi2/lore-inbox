Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUJBHpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUJBHpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 03:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUJBHpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 03:45:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:39908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267338AbUJBHoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 03:44:38 -0400
Date: Sat, 2 Oct 2004 00:42:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails in 2.6.9-rc2-mmX
Message-Id: <20041002004221.33510f46.akpm@osdl.org>
In-Reply-To: <20040928214246.41b80d30.khali@linux-fr.org>
References: <20040928214246.41b80d30.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> I think I found a bug in 2.6.9-rc2-mm4. It doesn't seem to be able to
> mmap() files located on cdroms. Same problem with -mm3 and -mm1.
> 2.6.9-rc2 works fine. I reproduced it on two completely different
> systems, so I guess it isn't device dependant.
> 

So I tried your .config

> ...
> # CONFIG_BLK_DEV_IDECD is not set

hm.  You're not using an IDE CDROM?

> CONFIG_BLK_DEV_SR=m

but you are using a SCSI CDROM, correct?

I tried your test app on both IDE CD with my .config and on SCSI CD with
your .config.  Works fine.


vmm:/mnt/cdrom> ~/test-mmap REGSVR32.EXE 
mmap size=42 flags=1: OK
mmap size=42 flags=2: OK
mmap size=4096 flags=1: OK
mmap size=4096 flags=2: OK


