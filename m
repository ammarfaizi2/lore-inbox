Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292727AbSBZTWV>; Tue, 26 Feb 2002 14:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSBZTWE>; Tue, 26 Feb 2002 14:22:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292727AbSBZTVm>;
	Tue, 26 Feb 2002 14:21:42 -0500
Message-ID: <3C7BDFE6.313AA43D@zip.com.au>
Date: Tue, 26 Feb 2002 11:20:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI 
 Watchdog detected LOCKUP
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org> <3C7BDC57.A835D657@zip.com.au>,
		<3C7BDC57.A835D657@zip.com.au> <20020226191626.GA11283@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Lohoff wrote:
> 
> On Tue, Feb 26, 2002 at 11:04:55AM -0800, Andrew Morton wrote:
> > > __block_prepare_write: zeroing uptodate buffer!
> >
> > Yup.   This happens when the disk fills up.  Andrea and I were
> > discussing it over the weekend.   There's a new patch in the -aa
> > kernels which doesn't quite fix it :(
> >
> > We'll fix it in 2.4.19-pre somehow.  It's possible that this problem
> > causes a chnuk of zeroes to be written into the file when you hit
> > ENOSPC, which is rather rude.  But your file was truncated anyway.
> 
> I dont think the machine had full filesystems at all.

I/O error when reading filesystem metadata would also cause it.
