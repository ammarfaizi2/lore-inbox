Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315176AbSEHVQg>; Wed, 8 May 2002 17:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315187AbSEHVQf>; Wed, 8 May 2002 17:16:35 -0400
Received: from codepoet.org ([166.70.14.212]:38881 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315176AbSEHVQe>;
	Wed, 8 May 2002 17:16:34 -0400
Date: Wed, 8 May 2002 15:16:34 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508211633.GA24938@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020508182139.GA22659@codepoet.org> <E175X9b-0002D0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 08, 2002 at 08:31:11PM +0100, Alan Cox wrote:
> > int i, type, major=0, minor=0;
> > for(i=0; i<26; i++) {
> >     snprintf(device_string, sizeof(device_string), "/dev/hd%c", 'a'+i);
> >     if ((fd=open(device_string, O_RDONLY | O_NONBLOCK)) < 0) {
> > 	continue;
> >     }
> 
> If it opened is it there. Suppose its an IDE floppy and no media is 
> present. Maybe its hiding in ide-scsi instead.  It ends up being detective
> work. 

That suggests to me that IDE floppy needs to be fixed to open
even when no media is present when provided with the  O_NONBLOCK
flag, which would be consistant with how CDROMs, and everything
SCSI works.

As for ide-scsi, I thought that was going to go away?  

> work. The /device set up makes it explicit and clean

agreed.  But I don't expect to see that showing up soon in 2.4.x,
which is what most people (like me) will be using for the next
year or two.  Sure 2.5.x it might work, but it might eat your
disk too.  So is groping about in /proc/ide the only way to get
reliable ide device detection for 2.4.x, or is there some other
way?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
