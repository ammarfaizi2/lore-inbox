Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311252AbSCSOKo>; Tue, 19 Mar 2002 09:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311258AbSCSOKd>; Tue, 19 Mar 2002 09:10:33 -0500
Received: from www.wen-online.de ([212.223.88.39]:53769 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311252AbSCSOKT>;
	Tue, 19 Mar 2002 09:10:19 -0500
Date: Tue, 19 Mar 2002 10:19:03 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <200203190739.g2J7dTq31402@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.10.10203191009290.5694-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Denis Vlasenko wrote:

> On 18 March 2002 15:20, Mike Galbraith wrote:
> > Greetings,
> >
> > Kernel version is 2.5.7-pre2 if that matters.
> >
> > I was reading lkml with a forgotten tcpdump running, when my son turned
> > on his windows box, blessing me with the usual msjunk.  Is the attached
> > just a tcpdump bug?  I had already read that message, and didn't really
> > expect to see it again.. not in my tcpdump log anyway :)
> 
> 8-(  We need SMB experts here...
> I presume your box is a Linux one. 

Yes.

> Is this packet went from your box to win box?

No, it looks to me like tcpdump just gets uncleared pages, makes a
booboo while processing ms packet and spits out old page content.

(security doesn't matter to me, but I figured maybe it shouldn't be
doing that.. worth sending a note just in case)

> What was running on your box? Samba?
> Did you use smbfs?

No samba here. (configured in, but I never found a round-tuit)

> 
> 16:42:49.412862 10.0.0.101.netbios-dgm > 10.255.255.255.netbios-dgm: 
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 bcast from your box to NetBIOS port?
> >>> NBT UDP PACKET(138) Res=0x1102 ID=0x54 IP=10.0.0.101 Port=138 Length=193 
> Res2=0x0 
> SourceName=T1H6I3          NameType=0x00 (Workstation) 
>            ^^^^^^ your hostname?

No, that's my son's winbox.

> DestName= 
> SMB PACKET: SMBunknown (REQUEST) 
> SMB Command   =  0x43 
> Error class   =  0x46 
> Error code    =  20550 
> Flags1        =  0x45 
> Flags2        =  0x4E 
> Tree ID       =  17990 
> Proc ID       =  18000 
> UID           =  16720 
> MID           =  16707 
> Word Count    =  66 
> SMBError = ERROR: Unknown error (70,20550) 
> --
> vda

	-Mike

