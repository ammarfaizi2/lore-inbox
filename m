Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRIRNEy>; Tue, 18 Sep 2001 09:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIRNEo>; Tue, 18 Sep 2001 09:04:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24292 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271226AbRIRNEi>;
	Tue, 18 Sep 2001 09:04:38 -0400
Date: Tue, 18 Sep 2001 09:04:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: David Chow <davidchow@rcn.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT from file read.
In-Reply-To: <Pine.LNX.3.95.1010918083824.20907A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.21.0109180900320.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Richard B. Johnson wrote:

> File I/O requires a process context. Your file descriptor means
> nothing unless associated with the process that opened the file.

It fscking doesn't.  He had clearly said that he calls file->f_op->read(),
which has nothing whatsofuckingever to descriptors.  Sod off and don't
return until you learn to read.

As for the original question - grep fro set_fs and you'll see what to
do (basically, set_fs(KERNEL_DS) before the call of ->read() and restore
afterwards).

