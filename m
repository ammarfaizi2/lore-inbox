Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSEVLZ7>; Wed, 22 May 2002 07:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSEVLZ6>; Wed, 22 May 2002 07:25:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18702 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312973AbSEVLZ6>; Wed, 22 May 2002 07:25:58 -0400
Message-Id: <200205221121.g4MBLUY02306@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Date: Wed, 22 May 2002 14:23:46 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        acme@conectiva.com.br
In-Reply-To: <5E5257A4137@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 22 May 02 at 12:27, Denis Vlasenko wrote:
> > > As Linus and others pointed out, copy_{to_from}_user has its uses and
> > > will stay, but something like:
> >
> > I don't say 'kill it', I say 'rename it so that its name tells users what
> > return value to expect'. However, one have to weigh
>
> Why?

Why what? Why rename copy_to_user? Because in its current form people
misunderstand its return value and misuse it.
We can keep unmodified version of copy_to_user for some time for
compatibility.

Or maybe your "why?" is related to something else, I fail
to understand you in that case.

> From copyin/out descriptions sent yesterday if you want same source code
> running on all (BSD,SVR4,OSF/1) platforms, you must do
>
> if (copyin()) return [-]EFAULT;

But if I am new to Linux and just want to write my first piece of kernel
code, copyout() is even worse than copy_to_user(): 
it too lacks info of what it can return (0/1, 0/-EFAULT, # of copied bytes,
# of bytes remaining?) *and* copy direction become unclear:
copy out of *what*? out of kernel memery? out of user memory?
--
vda
