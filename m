Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311498AbSCNDcJ>; Wed, 13 Mar 2002 22:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311499AbSCNDcA>; Wed, 13 Mar 2002 22:32:00 -0500
Received: from harddata.com ([216.123.194.198]:39940 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S311498AbSCNDbs>;
	Wed, 13 Mar 2002 22:31:48 -0500
Date: Wed, 13 Mar 2002 20:32:39 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020313203239.A5381@mail.harddata.com>
In-Reply-To: <20020312134631.GE1473@suse.de> <Pine.LNX.4.21.0203121558300.3462-100000@freak.distro.conectiva> <20020313080946.GC15877@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020313080946.GC15877@suse.de>; from axboe@suse.de on Wed, Mar 13, 2002 at 09:09:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 09:09:46AM +0100, Jens Axboe wrote:
> 
> So why does 2.4.19-pre3 work for pio at all? For the same reason that
> Andre never found this problem in 2.5 either: the taskfile interrupt
> handlers are _never_ used in pio mode. In 2.5 it was by accident, and
> when the merge happened they did indeed get used. It ate disks, very
> quickly. ...

Well, I tried 2.4.19-pre3 yesterday (Alpha with an IDE drive) and
my ext2 file system is indeed gone.  I do not want to claim that this
is certainly due to an IDE driver from 2.4.19-pre3, as this is
a machine with a number still open issues and very experimental
installation, but it survived a number of very rough attempts on
file systems in the past and now it died.  This _could be_ coincidental;
I did use various kernels from "ac" series on it in the past.

BTW  - e2fsck made an impression that it is running in circles.
After mounting a disk from another system I have leftovers and number
of files can be read and copied but, among other things, '/lib' is
not a directory anymore. :-)

  Michal
