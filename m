Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271093AbRHTHUJ>; Mon, 20 Aug 2001 03:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271098AbRHTHUA>; Mon, 20 Aug 2001 03:20:00 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7949 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271093AbRHTHTt>; Mon, 20 Aug 2001 03:19:49 -0400
Message-ID: <3B80B9D0.139E4567@idb.hist.no>
Date: Mon, 20 Aug 2001 09:18:40 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Jeff Meininger <jeffm@boxybutgood.com>, linux-kernel@vger.kernel.org
Subject: Re: 'detect' floppy hardware from userland?  ioctl?
In-Reply-To: <Pine.LNX.4.33.0108171628470.550-100000@mangonel.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Meininger wrote:
> 
> I'm writing an app that needs to know what floppy drives are connected to
> the system.  Right now, I'm parsing the output of 'dmesg', but 'dmesg' can
> fill up so that the part where floppy drives are listed is no longer
> available.  Is there an ioctl or some other interface for discovering fd0,
> fd1, etc?
>

You have got some replies already.  Another way of detection is
to run devfs, you may do a "ls /dev/floppy" and get
0, 1, 2, ...
devfs report exactly the devices you have, not the devices
you _may_ have.  Note that you don't have to convert
your system to use devfs if you don't want to - you can
mount devfs some other place than /dev if all you want
is detection.

Helge Hafting
