Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbRBYJP3>; Sun, 25 Feb 2001 04:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbRBYJPU>; Sun, 25 Feb 2001 04:15:20 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:61197 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129957AbRBYJPI>; Sun, 25 Feb 2001 04:15:08 -0500
Date: Sun, 25 Feb 2001 22:15:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Don Dugger <n0ano@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: Core dumps for threads
Message-ID: <20010225221505.A12595@metastasis.f00f.org>
In-Reply-To: <20010224134523.O26109@valinux.com> <E14WmhG-0000Yj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14WmhG-0000Yj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Feb 24, 2001 at 09:57:44PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 09:57:44PM +0000, Alan Cox wrote:

    The I/O to dump the core would race other changes on the mm. The
    right fix is probably to copy the mm (as fork does) then dump the
    copy.

Stupid question... but since all threads see the same memory space as
each other; can we not lock the entire vma for the process whilst
it's being written out?



  --cw
