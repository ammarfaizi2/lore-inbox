Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290974AbSBGANM>; Wed, 6 Feb 2002 19:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290987AbSBGAM4>; Wed, 6 Feb 2002 19:12:56 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:36492 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290974AbSBGAMl>; Wed, 6 Feb 2002 19:12:41 -0500
Date: Wed, 6 Feb 2002 19:12:33 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206191233.I21624@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20020206163118.E21624@devserv.devel.redhat.com> <E16YcJW-0006vG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16YcJW-0006vG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 07, 2002 at 12:21:22AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 12:21:22AM +0000, Alan Cox wrote:
> > This is not possible, since then %gs:0 (which is TLS base) cannot be read.
> > We would have to change the TLS ABI (thus become incompatible e.g. with Sun)
> 
> Sun who have canned their x86 product it seems. I don't feel "the standard
> requires we suck" is an appropriate justification for anything. If there 
> is not a sane way to follow the standard - break it. If there is a sane way
> then all fair and good, find it and use it

We have changed it already (e.g,. for regparm(1), fewer relocs, shorter insn
sequences, etc.), but with exception of 2 non-dynamic relocs (which get
different numbers) we are still compatible.
But as written later, just using a different GDT descriptor could avoid
having to change the ABI, but would still have the undesirable property of
requiring every app to mmap a new page at fixed location.

	Jakub
