Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270646AbRHSTAA>; Sun, 19 Aug 2001 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270676AbRHSS7u>; Sun, 19 Aug 2001 14:59:50 -0400
Received: from mail.LF.net ([212.9.160.2]:44560 "EHLO mail.LF.net")
	by vger.kernel.org with ESMTP id <S270646AbRHSS7n>;
	Sun, 19 Aug 2001 14:59:43 -0400
Message-ID: <3B800CA3.AF9E321F@janglednerves.com>
Date: Sun, 19 Aug 2001 20:59:47 +0200
From: Albrecht Jacobs <Albrecht.Jacobs@janglednerves.com>
Organization: jangled nerves GmbH
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
CC: "(Martin Jacobs)" <100.179370@germanynet.de>, linux-kernel@vger.kernel.org
Subject: Re: Q: 2.4.[37]-XFS: /dev/nst0m: cannot allocate memory
In-Reply-To: <Pine.LNX.4.33.0108181033140.12556-100000@kai.makisara.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara wrote:
> 
> On Fri, 17 Aug 2001, (Martin Jacobs) wrote:
> 
> > Hi all,
> >
> > I cannot read anything from my tape (Tandberg DLT8000, LVD
> > interface, ID=5) connected to an aic7899 or an sym53c895 using
> > kernel 2.4.3-XFS or 2.4.7-XFS. (Everything works fine on
> > 2.2.16.) Loading of st.o works. stinit works. mt (status, tape
> > positioning) works. But when I try to read the amanda header
> > from the tape (dd if=/dev/nst0m bs=32k count=1) I get the
> > error
> >
> > dd: reading `/dev/nst0m': Cannot allocate memory
> >
> ...
> > Nearly the same for tar (with default block size of 512 byte).
> >
> > BUT: if I use bs=64k it works!!?
> >
> In variable block mode in 2.4, you get ENOMEM if the block on the tape is
> larger than the byte count in the read(). 2.2 just returned what you asked
> for and silentlry threw away the rest of the block. If the byte count is
> larger than the block size, then the block is returned.
> 
> I.e., the first block on your tape is larger than 32 kB.
> 
>         Kai

If I understand you right this is a FEATURE, not a bug! I find it quite
irritating when using a tape device. Shouldn't I get some error message
about wrong block size?
	Forgive me but I am some sort of end user (admin) and not a kernel
hacker.
BTW, where can I get documentation about this 'feature'?
 
Thanks anyway!

-- 
albrecht jacobs

jangled nerves gmbh
hallstrasse 25
d-70376 stuttgart

fon:   +49 711 550375-44
fax:   +49 711 550375-22

mailto:albrecht.jacobs@janglednerves.com
http://www.janglednerves.com/
