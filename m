Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbSJ1GLZ>; Mon, 28 Oct 2002 01:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbSJ1GLZ>; Mon, 28 Oct 2002 01:11:25 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:896 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262888AbSJ1GLZ> convert rfc822-to-8bit; Mon, 28 Oct 2002 01:11:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Christoph Hellwig <hch@infradead.org>, Kenneth Johansson <ken@kenjo.org>
Subject: Re: rootfs exposure in /proc/mounts
Date: Sun, 27 Oct 2002 20:17:32 -0500
User-Agent: KMail/1.4.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Andreas Haumer <andreas@xss.co.at>,
       linux-kernel@vger.kernel.org, willy@w.ods.org
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <1035763409.4176.5.camel@tiger> <20021028001831.A31614@infradead.org>
In-Reply-To: <20021028001831.A31614@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210271917.32650.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 18:18, Christoph Hellwig wrote:
> On Mon, Oct 28, 2002 at 01:03:28AM +0100, Kenneth Johansson wrote:
> > On Sun, 2002-10-27 at 16:09, Christoph Hellwig wrote:
> > > you might have very different mounts in different processes.
> >
> > You can ?? apart from chroot that can make things interesting  how do
> > you do this?
>
> clone(..., CLONE_NEWNS, ...)
>
> After that subsequent namespace operations will only affect your process
> and it's child processes.

Cool.

Question: if those processes mount something and then exit, does that 
something get unmounted automatically or is this a mount point leak?

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
