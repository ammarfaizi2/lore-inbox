Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbULPUA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbULPUA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULPUA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:00:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21673 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261941AbULPUAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:00:52 -0500
Date: Thu, 16 Dec 2004 21:00:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <20041216113357.4c2714bb@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.61.0412162059230.14657@yvahk01.tjqt.qr>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
 <20041216113357.4c2714bb@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?
>> What do people want?  I guess it's time to write up a LSB proposal :(
>
>The /proc sounds
>better, but mounting anything under /proc requires a kernel component
>to create a directory, does it not?

And in case you debug procfs itself, you usually should not or even can't 
mount it into /proc, e.g. /proc is currently being initialised, but debugfs 
values already spit out.

/.debugfs/ as my choice, to not pollute/fill the root directory that much :)



Jan Engelhardt
-- 
ENOSPC
