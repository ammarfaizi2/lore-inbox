Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946907AbWKAPic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946907AbWKAPic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946906AbWKAPic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:38:32 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:1332 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1946907AbWKAPib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:38:31 -0500
Message-ID: <4548BF7A.4090602@cfl.rr.com>
Date: Wed, 01 Nov 2006 10:38:34 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18/Reiser3 - lost directory and strange warnings
References: <20061101082331.GA6438@gimli>
In-Reply-To: <20061101082331.GA6438@gimli>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2006 15:38:39.0871 (UTC) FILETIME=[CDBF90F0:01C6FDCB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14786.003
X-TM-AS-Result: No--9.144500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lorenz wrote:
> panic arose about an hour ago...
> a whole directory tree was suddenly gone and every try to access it resulted
> in an i/o error
> 
> the log shows this:

<snip>

> 
> a reboot into maintainance mode and fsck of the partition brought the dir
> back without data loss (pffffew!)
> 
> but I am still concerned, what has happened here?
> 

Your partition was damaged.

> a grep on my syslogs revealed quite a few similar warnings which I obviously
> diden't notice. - attached wich a few lines of context

Check for disk IO errors, and you also might want to run badblocks 
and/or the smartmontools on the device to check for hardware errors. 
Also a memtest86 for a few hours to rule out corrupted ram.

> 
> see http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D for more
> 
> 
> gruss
>   mlo
> --
> Dipl.-Ing. Martin Lorenz
> 
>             They that can give up essential liberty 
> 	    to obtain a little temporary safety 
> 	    deserve neither liberty nor safety.
>                                    Benjamin Franklin
> 
> please encrypt your mail to me
> GnuPG key-ID: F1AAD37D
> get it here:
> http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D
> 
> ICQ UIN: 33588107
> 
