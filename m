Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130410AbRCBLI0>; Fri, 2 Mar 2001 06:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRCBLIQ>; Fri, 2 Mar 2001 06:08:16 -0500
Received: from inpbox.inp.nsk.su ([193.124.167.24]:5761 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S130410AbRCBLII>; Fri, 2 Mar 2001 06:08:08 -0500
Date: Fri, 2 Mar 2001 16:56:37 +0600
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: linux-kernel@vger.kernel.org
Subject: Re: ftruncate not extending files?
In-Reply-To: <20010302084544.A26070@home.ds9a.nl>
Message-ID: <Pine.SGI.4.10.10103021611250.3250157-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, bert hubert wrote:

> > ftruncate() and truncate() may extend a file but they are not required to
> > do so.
> 
> I would've sworn, based on the fact that I saw people do it, that ftruncate
> was a legitimate way to extend a file - especially useful in combination
> with mmap().

lseek and write does it already and need not to duplicate with truncate().
Using truncate() to extend a file sounds very strange.

About mmap() SUSv2 says:

If the size of the mapped file changes after the call to mmap() as a
result of some other operation on the mapped file, the effect of
references to portions of the mapped region that correspond to added or
removed portions of the file is unspecified.
                                ^^^^^^^^^^^
What do you mean about "useful in combination with mmap()" ?


> I don't really care where it is done, in glibc or in the kernel - but let's
> honor this convention and not needlessly break code.

Let's don't connive to ill-formed programs.

--

