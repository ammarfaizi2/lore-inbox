Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbREHQV1>; Tue, 8 May 2001 12:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbREHQVR>; Tue, 8 May 2001 12:21:17 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:34830 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132850AbREHQVE>;
	Tue, 8 May 2001 12:21:04 -0400
Date: Tue, 8 May 2001 18:20:55 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        alexander.eichhorn@rz.tu-ilmenau.de, linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
Message-ID: <20010508182055.A19608@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0105071106470.10009-100000@twinlark.arctic.org> <E14wt2p-00048d-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14wt2p-00048d-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 07, 2001 at 10:59:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > so there's still single copy for write() of a mmap()ed page?
> 
> An mmap page will go direct to disk.

Looking at the 2.4.4 code, mmap() of file followed by write() to socket
will copy the data once.

I could be mistaken (only glanced at the code quickly) but I base that
on the only call to ->sendpage being through sendfile.

So yes, there's a single copy overhead for mmap()+write().

-- Jamie
