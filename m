Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbTEIX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTEIX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:27:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263576AbTEIX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:27:23 -0400
Subject: RE: ext3/lilo/2.5.6[89] (was: [KEXEC][2.5.69] kexec for
	2.5.69available)
From: Andy Pfiffer <andyp@osdl.org>
To: Riley Williams <Riley@Williams.Name>
Cc: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
In-Reply-To: <BKEGKPICNAKILKJKMHCACEJHCLAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCACEJHCLAA.Riley@Williams.Name>
Content-Type: text/plain
Organization: 
Message-Id: <1052523563.1208.2.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 May 2003 16:39:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 13:46, Riley Williams wrote:
> Hi Andy, Christophe.
> 
>  >>> I had an unrelated delay in posting this due to some strange
>  >>> behavior of late with LILO and my ext3-mounted /boot partition
>  >>> (/sbin/lilo would say that it updated, but a subsequent reboot
>  >>> would not include my new kernel)
> 
>  >> So I'm not the only one having this problem... I think I first
>  >> saw this with 2.5.68 but I'm not sure.
> 
>  > Well, that makes two of us for sure.
> 
>  >> My boot partition is a small ext3 partition on a lvm2 volume
>  >> accessed over device-mapper (I've written a lilo patch for
>  >> that, but the patch is working and) but I don't think that has
>  >> something to do with the problem.
>  >>
>  >> When syncing, unmounting and waiting some time after running
>  >> lilo, the changes sometimes seem correctly written to disk, I
>  >> don't know when exactly.
>  >
>  > My /boot is an ext3 partition on an IDE disk. My symptoms and
>  > your symptoms match -- wait awhile, and it works okay. If you
>  > don't wait "long enough" the changes made in /etc/lilo.conf are
>  > not reflected in the after running /sbin/lilo and rebooting
>  > normally.
> 
> One suggestion: ext3 is a journalled version of ext2, so if you can
> boot with whatever is needed to specify that the boot partition is
> to be mounted as ext2 rather than ext3, you can isolate the journal
> system: If the problem's still there in ext2 then the journal is
> not involved, but if the problem vanishes there, it's something to
> do with the journal.

Changing the "ext3" to "ext2" in /etc/fstab and rebooting did not change
the behavior (ie, edit /etc/lilo.conf, run /sbin/lilo, reboot cleanly,
changes not there).  I did see the warning about mounting an ext3
filesystem as ext2, however.

Strange.



