Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315194AbSEDTop>; Sat, 4 May 2002 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSEDToo>; Sat, 4 May 2002 15:44:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3080 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315194AbSEDToo>; Sat, 4 May 2002 15:44:44 -0400
Message-Id: <200205041941.g44JfIX12511@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Date: Sat, 4 May 2002 22:46:27 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <3CD2875C.439AC914@aitel.hist.no> <5.1.0.14.2.20020503224831.00ac7520@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002 19:50, Anton Altaparmakov wrote:
> > > Changing unix is doable _if_ you can show a significant benefit.
> > > The more utilities you want to break, the more benefit you need to
> > > show. I don't think you can send the inode to the land of
> > > "8-char limited passwords" by pushing "simpler management of fstabs"
> > > though.
> >
> >I'm afraid I can't present benefits big enough.
> >
> >I was thinking of fs driver (NFS,reiser,NTFS,FAT,...) developers'
> >pain, not about my /etc/fstab editing.
>
> NTFS has native inode numbers which are persistent across reboot so this is
> a non-issue. The only thing is that inode numbers on ntfs are 64 bit and
> not 32 bit but that is much a user space issue as a kernel issue...

Sure it is fixable, we can slowly drift to 64bit inodes in libc.

OTOH, why I have this subtle feeling that there is (or will be)
SuperHyperDuperFS with 128bit inodes?

That is one reason why I don't like inode numbers.
--
vda
