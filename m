Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314801AbSECRq2>; Fri, 3 May 2002 13:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSECRq1>; Fri, 3 May 2002 13:46:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12809 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314801AbSECRq1>; Fri, 3 May 2002 13:46:27 -0400
Message-Id: <200205031743.g43HhkX10360@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Date: Fri, 3 May 2002 20:47:48 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au> <200205030931.g439VEX09418@Port.imtp.ilyichevsk.odessa.ua> <3CD2875C.439AC914@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002 10:49, Helge Hafting wrote:
> > > Yes, edit /etc/fstab. My file server has loads of partitions and it
> > > exports them all and /etc/fstab on all clients just mounts them all.
> > > Problem being?
> >
> > Problem is that I have to modify /etc/fstab on every workstation.
>
> So _automate_ that then.  If you have so many workstations, make...

Yes I can do that easily. I meant that it is somewhat silly that clients
have to be tweaked when normal directory on server become a mount point.
It should be invisible from client.

(Before we start: I know about nohide)

> > It seems to me like the Bad Thing which is too old and traditional to
> > change. :-(
>
> Most ways have their own disadvantages.  Can you invent a better concept
> than the inode that works as well in every existing way, and better for
> this case?  Your new syscall isn't it, as Pavel Machek demonstrated.

Pavel presented a corner case (tarring up thousands of files, all with
exactly *same size*). It's like making pathological cases for VM behavior.
I don't take that seriously, sorry. Another example?

> Changing unix is doable _if_ you can show a significant benefit.
> The more utilities you want to break, the more benefit you need to show.
> I don't think you can send the inode to the land of
> "8-char limited passwords" by pushing "simpler management of fstabs"
> though.

I'm afraid I can't present benefits big enough.

I was thinking of fs driver (NFS,reiser,NTFS,FAT,...) developers'
pain, not about my /etc/fstab editing.
--
vda
