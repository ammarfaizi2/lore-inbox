Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTKFWuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 17:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbTKFWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 17:50:20 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:51078 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S263851AbTKFWuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 17:50:12 -0500
Date: Thu, 6 Nov 2003 20:49:20 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Problems with USB Drive
Message-ID: <20031106224920.GA2638@ime.usp.br>
References: <20031105175609.GA967@ime.usp.br> <20031106022528.GA3636@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031106022528.GA3636@ime.usp.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06 2003, Rogério Brito wrote:
> Just as some extra information, when I try to shutdown the hotplug
> service (via /etc/init.d/hotplug stop), the program hangs and I get
> processes in the D state in the output of ps.
> 
> Also, when this occurs, lsmod also hangs and is also unkillable.
(...)

Here are some extra pieces of information regarding what people told me
or recommended me:

  * I am already using UHCI, and not OHCI (in particular, I am using the
    uhci_hcd module);

  * I tried inserting my USB drive slowly, but it seemed to make no
    difference;

  * Before inserting the USB drive, I already have scsi_mod, ide_scsi,
    sd_mod, usbcore and usblp loaded.

The bad thing is that apart from not being able to store my files in my
drive, this process is leaving some unkillable processes in my system as
shows the following excerpt from an execution of the command "ps aux":

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root      2650  0.0  1.2  2648 1536 pts/0    S    20:14   0:00 -su
root      2757  0.0  0.3  1524  464 pts/0    T    20:19   0:00 /bin/sh /etc/init.d/hotplug status
root      2772  0.0  0.9  2384 1184 pts/0    T    20:19   0:00 /bin/bash /etc/hotplug/usb.rc status
root      2778  0.0  0.3  1504  448 pts/0    D    20:19   0:00 grep ^[TPSI]: /proc/bus/usb/devices
root      2795  0.0  0.6  2452  828 pts/0    R    20:22   0:00 ps aux
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

As a reminder, the last lines of my dmesg output that seems relevant to
the problem is attached to this message. After that, I get the message
that /dev/sda1 is not a valid block device.

I put all the relevant files that I can think of on my homepage, at
<http://www.ime.usp.br/~rbrito/usb/> for further reference.

Please feel free to ask me whatever you feel is important and I will do
my best to answer to get this working correctly.


Thanks in advance, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
