Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131659AbRC0Wjr>; Tue, 27 Mar 2001 17:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131662AbRC0Wjh>; Tue, 27 Mar 2001 17:39:37 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:54593 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131659AbRC0Wj3>; Tue, 27 Mar 2001 17:39:29 -0500
Date: Tue, 27 Mar 2001 16:38:02 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103272238.QAA38706@tomcat.admin.navo.hpc.mil>
To: hpa@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Alan Cox wrote:
> > 
> > > high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
> > > hogging a major number, but letting low-level drivers get at _their_
> > > requests directly.
> > 
> > A major for 'disk' generically makes total sense. Classing raid controllers
> > as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> > solve a lot of misery
> > 
> 
> But it might also cause just as much misery, specifically because things
> move around too much.

That can be handled. It calls for using a volume name or UUID on file
systems and allowing mount to accept the volume name.

One way would be to add the volume identifier (whatever it ends up being)
to the /proc/partitions file. Then mount could search that table for
the volume name and use the associated device definitions to accomplish
the mount.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
