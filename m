Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVIGKWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVIGKWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVIGKWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:22:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbVIGKWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:22:07 -0400
Date: Wed, 7 Sep 2005 03:20:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pascal GREGIS <pgs@synerway.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: ide-scsi bug with ide tape drives
Message-Id: <20050907032019.755fff46.akpm@osdl.org>
In-Reply-To: <20050906091913.GB454@thundax>
References: <20050906091913.GB454@thundax>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal GREGIS <pgs@synerway.com> wrote:
>
>  I have a big problem that I supposed to be a bug of ide-scsi, eventhough I'm not totally sure of this.
> 
>  I am using manual tape drives, some of them are real scsi drives and the others are ide drives, on some Linux systems that I recently upgraded to kernel 2.6.12.3.
>  The problem is that, with this kernel version, when I read from my ide tape drives, the read does not stop, when it has finished with the real tape data, it keeps on reading \0 characters.
>  This problem is new with the kernel 2.6.12.3, or at least with 2.6.12 (it doesn't happen in 2.6.10 nor in 2.6.11.11) and it does only occur with the ide drives, with the scsi ones it returns correctly. This is why I suppose it is a bug of the ide-scsi module.

There were quite a few changes in ide-scsi.c between 2.6.11 and 2.6.12. 
Bart, could you please take a look?

