Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290060AbSAKSc5>; Fri, 11 Jan 2002 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290061AbSAKScr>; Fri, 11 Jan 2002 13:32:47 -0500
Received: from ns.caldera.de ([212.34.180.1]:55751 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290060AbSAKScg>;
	Fri, 11 Jan 2002 13:32:36 -0500
Date: Fri, 11 Jan 2002 19:31:56 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] ext2, sysvfs, minixfs directory syncs
Message-ID: <20020111193156.A24475@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@math.psu.edu>
In-Reply-To: <3C3E9A76.F9DEFF96@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3E9A76.F9DEFF96@zip.com.au>; from akpm@zip.com.au on Thu, Jan 10, 2002 at 11:55:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 11:55:34PM -0800, Andrew Morton wrote:
> I've only tested ext2.    Christoph, could you please test the
> sysvfs changes?   Thanks.

The change if fine.

> --- linux-2.4.18-pre3/fs/sysv/ChangeLog	Fri Dec 21 11:19:23 2001
> +++ linux-akpm/fs/sysv/ChangeLog	Thu Jan 10 23:19:00 2002
> @@ -20,3 +20,8 @@ Fri Oct 26 2001  Christoph Hellwig  <hch
>  	Remove symlink faking.	Noone really wants to use these as
>  	linux filesystems and native OSes don't support it anyway.
>  
> +Thu Jan 10 2002  Andrew Morton  <akpm@zip.com.au>
> +
> +	* dir.c: use sync_one_page() rather than waitfor_one_page() for

This should be dir.c (dir_commit_chunk): ....
Also new changelog items get added at the top.

	Christoph
