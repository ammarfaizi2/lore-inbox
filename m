Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310160AbSCAXIj>; Fri, 1 Mar 2002 18:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310157AbSCAXId>; Fri, 1 Mar 2002 18:08:33 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:42393 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310216AbSCAXH6>; Fri, 1 Mar 2002 18:07:58 -0500
Date: Fri, 1 Mar 2002 16:22:02 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301162202.B12413@vger.timpanogas.org>
In-Reply-To: <3C7FE7DD.98121E87@zip.com.au> <E16guBW-00051l-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16guBW-00051l-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 09:03:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 09:03:22PM +0000, Alan Cox wrote:
> > I don't immediately see why increasing the queue length should
> > increase bandwidth in this manner.  One possibility is that
> 
> Latency on the controllers ?  With caches on the controller and disks you
> can have a lot of requests actually in flight


Since 3ware uses a switched architecture, there are a lot of requests
in flight.  Can we get the default value increased or alternately, allow 
RAID drivers to submit a local queue_nr_request value per adapter 
so for those cards with 8 drives that make themselves look like
a single drive to Linux, sufficient buffers are available to prevent
threads feeding the device from going to sleep all the time?

:-)

Jeff

