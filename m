Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265917AbSKBJO2>; Sat, 2 Nov 2002 04:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265918AbSKBJO1>; Sat, 2 Nov 2002 04:14:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49334 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265917AbSKBJO1>;
	Sat, 2 Nov 2002 04:14:27 -0500
Date: Sat, 2 Nov 2002 10:20:40 +0100
From: Jens Axboe <axboe@suse.de>
To: chrisl@vmware.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sasha Malchik <sasha@vmware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE CDROM packet command buffer size restriction.
Message-ID: <20021102092040.GE31088@suse.de>
References: <20021101044646.GB8603@vmware.com> <20021101121045.GK8428@suse.de> <20021102091049.GA1673@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102091049.GA1673@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, chrisl@vmware.com wrote:
> On Fri, Nov 01, 2002 at 01:10:45PM +0100, Jens Axboe wrote:
> > > We make a patch allow kernel return successful and return the actual
> > > transfer data size. Is it the prefer behavior in this case? If not,
> > > what is the best way to solve this problem?
> > 
> > The patch does look good, thanks.
> 
> Sasha just find my change to the patch has some fault. The pc.buflen
> changed after cdrom_queue_packet_command. So his original patch
> is more correct.
> 
> I paste it here again. I am sorry for the confusion.

Depends on whether you want the residual or the amount transferred.
Amount transferred probably makes more sense here, I agree.

-- 
Jens Axboe

