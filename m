Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbULPOhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbULPOhf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbULPOhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:37:25 -0500
Received: from mail0.lsil.com ([147.145.40.20]:38120 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261936AbULPOfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:35:37 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57058BF9C9@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Thu, 16 Dec 2004 09:27:02 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2004-12-15 at 15:30 -0600, Matt Domsch wrote:
> > Do you plan to apply LSI's driver patch which adds the 
> driver-private 
> > ioctl to provide the mapping from logical drive address to 
> HCTL value?
> > Both Dell and LSI have products which are lined up to use this new 
> > ioctl because it's the most expedient thing to do, 
> maintains internal 
> > project schedules, etc, which delaying until this sysfs 
> mechanism hits 
> > will greatly impact those schedules. (I know, many folks on 
> this list 
> > don't care about business-side impacts of choices made on-list.)
> 
> I'm strongly against adding this. The reason for that is that 
> once an ioctl is added, it realistically will and can never go away.

This issue has gone from the utility of the ioctl in question (which has
been discussed in detail on the list) to now outright rejection of the
driver ioctls. If this is the idea, drivers would need to consciously move
the driver only ioctls to sysfs. Which may be good for simple ioctls like
these but might now be elegant for complex transfers. So, IMO, drivers need
both of the interfaces and should make a good judgment call on services
provided by each interface.

>
> that is no reason to foul up the kernel more. 
> 
The ioctl in question has been discussed in detail and was deemed
appropriate ioctl to provide important service to the management
applications for device hot plugging. Schedules are one side of the story,
but we must not overlook the importance of the reason to have this ioctl in
the first place. If there are other preferred ways to implement the similar
functionality, we would be more than happy to consider that.

Thanks
-Atul Mukker
