Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289374AbSAPDlw>; Tue, 15 Jan 2002 22:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289965AbSAPDln>; Tue, 15 Jan 2002 22:41:43 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:10942 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290068AbSAPDla>; Tue, 15 Jan 2002 22:41:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: Hardwired drivers are going away?
Date: Tue, 15 Jan 2002 13:39:48 -0500
X-Mailer: KMail [version 1.3.1]
Cc: peter@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020115025840.11509.qmail@science.horizon.com> <E16QSxC-0004yp-00@the-village.bc.nu> <20020115.043911.21332087.davem@redhat.com>
In-Reply-To: <20020115.043911.21332087.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116034129.CRCX26021.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 07:39 am, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Tue, 15 Jan 2002 12:44:38 +0000 (GMT)
>
>    If at boot time we keep a big chunk of ram free at the kernel end and
> just load modules one after each other into that space until we get into
> real paging that problem goes away
>
> And we do have module_map/module_unmap interfaces already so it's
> easy to toy with this.
>
> I've always been meaning to do a "alloc 4MB page at boot, lock into
> TLB, carve module pages out of that, vmalloc when that runs out" on
> sparc64.

How would this handle modules being unloaded?  Are you going to try to pack 
the space, try to re-use the holes (allowing fragmentation), handle unloading 
the last module only (high water mark), or just ignore it and basically not 
allow modules to ever be unloaded?

Just curious...

Rob

