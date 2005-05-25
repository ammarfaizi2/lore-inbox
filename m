Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVEYN3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVEYN3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVEYN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:28:49 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:36104 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262350AbVEYN1E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:27:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cGvmLtXU9oihD/0TfX7A9TvmyuoD02SPp63vC6e3Nd0IzYfdF0XuUb1i5rCjC4rNWKh/D1sYIlgH2oJzJ+JJoIMLZKF30tHwqSpCV+PB7gJyrVgYQKhq1biAfcv7/NLRCnt+4a/IOjb7Hm0x+msKDQ7mEdH9knG6j/AZwdDqW6Y=
Message-ID: <58cb370e0505250627219ad709@mail.gmail.com>
Date: Wed, 25 May 2005 15:27:01 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.12-rc4, -mm: bad ide-cs problems
Cc: Andreas Steinmetz <ast@domdv.de>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050525130541.GA1960@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050525112745.GA1936@elf.ucw.cz>
	 <20050525112824.GA2892@elf.ucw.cz> <42946451.9070301@domdv.de>
	 <20050525130541.GA1960@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > > hde: cache flushes not supported
> > >  hde: hde1
> > > ide-cs: hde: Vcc = 3.3, Vpp = 0.0
> > >  hde: hde1
> > >  hde: hde1
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000010
> > >  printing eip:
> > > c033d618
> > > *pde = 00000000
> > > Oops: 0000 [#1]
> > > PREEMPT
> > > Modules linked in:
> > > CPU:    0
> > > EIP:    0060:[<c033d618>]    Not tainted VLI
> > > EFLAGS: 00010292   (2.6.12-rc4)
> > > EIP is at ide_drive_remove+0x8/0x10
> > > eax: c07825f8   ebx: c0782704   ecx: c07826f0   edx: 00000000
> > > esi: c07826e0   edi: c065fed8   ebp: 00000001   esp: dfce5e84
> > > ds: 007b   es: 007b   ss: 0068
> > > Process pccardd (pid: 932, threadinfo=dfce4000 task=dfc84a40)
> > > Stack: c02dc4b4 c07826e0 c065fa00 c0782568 c02dc724 c07826e0 c0782a80
> > > c02db5e2
> > >        c07826e0 df373a80 c02db628 c07825f8 c033bcfb c0782568 00000002
> > > df373b80
> > >        df373b80 c0670680 c0670728 c034f63b df758200 00000000 c034f67a
> > > c0386108
> > > Call Trace:
> > >  [<c02dc4b4>] device_release_driver+0x74/0x80
> >
> > Pavel,
> > I had a similar problem which I fixed amd posted to lkml a while ago
> > though I seems to got ignored by the ide maintainer. Please see if this
> > helps in your case:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111409743421578&w=2
> 
> Yes, thanks, that works. Andrew, is there reason not to push that
> patch into -mm/linus?

Full fix is in -mm (but still needs few changes).
