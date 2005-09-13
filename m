Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVIMNqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVIMNqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVIMNqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:46:51 -0400
Received: from ozlabs.org ([203.10.76.45]:41107 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964773AbVIMNqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:46:50 -0400
Date: Tue, 13 Sep 2005 23:17:39 +1000
From: Anton Blanchard <anton@samba.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050913131739.GD26162@krispykreme>
References: <20050913124804.GA5008@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913124804.GA5008@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> My ppc64 box refuses to boot with 2.6.14-rc1. The console log
> is included below. I see a lot of repeat of the last message
> in the log and then the box hangs.
> 
> Any idea what might have caused this ?

...

> Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> sdc: Spinning up disk....<6> target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)

Looks like a change between 2.6.13-git11 and 2.6.14-rc1 caused this - so
something in the last 24 hours.

Anton
