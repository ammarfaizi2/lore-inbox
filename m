Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264616AbTEPXmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264618AbTEPXmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:42:33 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:48288 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264616AbTEPXmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:42:32 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Manuel Estrada Sainz <ranty@debian.org>
Subject: Re: request_firmware() hotplug interface, third round.
Date: Sat, 17 May 2003 01:55:15 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com>
In-Reply-To: <20030516223624.GA16759@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305170155.15295.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
>
> Nice, but can't you get rid of the loading file by just relying on
> open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
> looks like you need that info.  But does the new binary interface in
> sysfs that just got merged into the tree provide that info for you?

But what if the close() is due to irregular termination?
If the script is killed, do you download half a firmware?

	Regards
		Oliver

