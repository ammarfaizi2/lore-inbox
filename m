Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSFUG5W>; Fri, 21 Jun 2002 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSFUG5V>; Fri, 21 Jun 2002 02:57:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15291 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316235AbSFUG5U>;
	Fri, 21 Jun 2002 02:57:20 -0400
Date: Fri, 21 Jun 2002 08:57:12 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: trelane@digitasaru.net
Subject: Re: CDROM (DVDROM) cd-rom problem
Message-ID: <20020621065712.GA21232@suse.de>
References: <20020620232857.A7249@ksu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620232857.A7249@ksu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20 2002, Joseph Pingenot wrote:
> Hello.  When I'm mounting and reading CD-ROMs, I get the following
>   error in the syslog:
> 
> Jun 20 23:23:28 jakob kernel: hdc: packet command error: status=0x51 [ drive ready,seek complete,error] 
> Jun 20 23:23:28 jakob kernel: hdc: packet command error: error=0x50
> Jun 20 23:23:28 jakob kernel: ATAPI device hdc:
> Jun 20 23:23:28 jakob kernel:   Error: Illegal request -- (Sense key=0x05)
> Jun 20 23:23:28 jakob kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)

It's hard to say what the problem is, because sense reporting is still
broken in 2.5. Notice how it's reporting a packet command error, but the
cdb dumped is the request sense command itself..

-- 
Jens Axboe

