Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSLMKfc>; Fri, 13 Dec 2002 05:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSLMKfc>; Fri, 13 Dec 2002 05:35:32 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:14598 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S261868AbSLMKfb>;
	Fri, 13 Dec 2002 05:35:31 -0500
Subject: Re: File still being accessed?
From: mdew <mdew@orcon.net.nz>
To: alexander.riesen@synopsys.COM
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212113738.GB1647@riesen-pc.gr05.synopsys.com>
References: <1039665790.602.5.camel@nirvana>
	<20021212085229.GA1647@riesen-pc.gr05.synopsys.com>
	<1039690223.463.11.camel@nirvana> 
	<20021212113738.GB1647@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Dec 2002 23:43:14 +1300
Message-Id: <1039776197.500.17.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 00:37, Alex Riesen wrote:
> mdew, Thu, Dec 12, 2002 11:50:19 +0100:
> > > > Under Linux 2.5.51 Ive noticed that Downloader4X (Getright-type for
> > > > linux) http://www.krasu.ru/soft/chuchelo/
> > > > 
> > > > when trying to resume a file, It thinks the file is still being
> > > > accessed, however under 2.4, it has no such problem. Is this a bug in
> > > > 2.5.x still? any patches available that could help?
> > > which d4x version, what _exactly_ the message states?
> > > -alex
> > I've tried both D4X GTK2 (2.4.0-rc1) based and GTK1.2.x (1.3.0) based, same results.
> > 
> > I add a download, let it partially download, then press
> > "Continue/Restart Downloads"
> > 
> > -> Retry 1 ...
> > -> Trying to connect...
> > -> Socket was opened!
> > -> Trying to create a file
> > +  File was created!
> > !! File is already opened by another download!
> > !! Downloading was failed...
> 
> The problem is advisory file locking. I'll try to debug
> it later, but something changed in how
> fcntl(fd, F_SETLK,{...,F_WRLCK,...}) works. It return an
> error now. Or maybe d4x just fails to unlock it, it doesn't
> check if unlock failed.
> The program doesn't show the real value of errno, just
> handles EINVAL and ENOLCK, so exact analisys is not possible
> apart something bad happened ("is already opened").
> The EINTR case, for instance, would cause similar behaviour.
> 
> I suppose d4x just incorrectly uses it, but cannot say anything
> for sure.
> The maintainer is notified.
> 
> -alex

email me, whenever its solved ;) other than that, I've found 2.5.51
pretty stable..its getting there.

many thanks
-mdew



