Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbQLKVqr>; Mon, 11 Dec 2000 16:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130884AbQLKVq2>; Mon, 11 Dec 2000 16:46:28 -0500
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:49801 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130883AbQLKVq0>; Mon, 11 Dec 2000 16:46:26 -0500
Date: Mon, 11 Dec 2000 13:10:19 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: hotplug mopup
To: Marcus.Meissner@caldera.de, linux-kernel@vger.kernel.org
Message-id: <3A3542BB.F2D7FA0F@pacbell.net>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11-pre5c i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - I don't think we can say that the kernel hotplug interface is 
> >   complete until we have real, working, tested userspace tools. David, 
> >   could you please summarise the state of play here? In particular, 
> >   what still needs to be done? 
> 
> Well, for USB I would like to know which device major/minor entry a newly 
> plugged device is associated with. 
> 
> Like if I insert a new USB camera, I want to easy find out it is char 81.1 
> (/dev/video1). Or if I plugin a USB storage device I want to easy find out 
> it is /dev/sda now. 

How might that relate to devfs integration?  It addresses similar
problems, and devfsd can call to userspace when such drivers (ones
that show up through major/minor device nodes) appear.  True, some
folk who want to hotplug might want to not run devfs.

- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
