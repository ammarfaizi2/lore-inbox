Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWHJRn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWHJRn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWHJRn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:43:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:49187 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422666AbWHJRn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:43:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ej+dCmqBZIu2AqZ3+VLNe9nv935kgaub6AfmvzPjIANcSAn4IKANdH/L3sk9FSPzT4r+Uq/WBHBnmRDBVeg95ANZG2ugASw9uFgA3X/Uj/52xmmIUohavvNXXzJY01899RTFIgDGFgvH7r1p6fk2sg4JKUmuKIA//lY7KBGTDSA=
Message-ID: <4af2d03a0608101043haac493ex272790b9ab8467d1@mail.gmail.com>
Date: Thu, 10 Aug 2006 19:43:42 +0200
From: "Jiri Slaby" <jirislaby@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jiri Slaby" <jirislaby@gmail.com>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: <20060810173312.GC21123@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
	 <20060809130151.f1ff09eb.akpm@osdl.org>
	 <200608092043.k79KhKdt012789@turing-police.cc.vt.edu>
	 <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu>
	 <44DB1AF6.2020101@gmail.com> <20060810082749.6b39a07b.akpm@osdl.org>
	 <20060810173312.GC21123@inferi.kami.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Mattia Dongili <malattia@linux.it> wrote:
> On Thu, Aug 10, 2006 at 08:27:49AM -0700, Andrew Morton wrote:
> > On Thu, 10 Aug 2006 13:39:11 +0159
> > Jiri Slaby <jirislaby@gmail.com> wrote:
> >
> > > Valdis.Kletnieks@vt.edu wrote:
> > > > On Wed, 09 Aug 2006 16:43:20 EDT, Valdis.Kletnieks@vt.edu said:
> > > >
> > > >>> Usually this means that there's an IO request in flight and it got lost
> > > >>> somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
> > > >>> lost interrupt (hardware bug, PCI setup bug, etc).
> > > >
> > > >> Aug  9 14:30:24 turing-police kernel: [ 3535.720000] end_request: I/O error, dev fd0, sector 0
> > > >
> > > > Red herring.  yum just wedged again, this time with no reference to floppy drive.
> > > > Same traceback.  Anybody have anything to suggest before I start playing
> > > > hunt-the-wumpus with a -mm bisection?
> > >
> > > Hmm, I have the accurately same problem...
> > > yum + CFQ + BLK_DEV_PIIX + nothing odd in dmesg
>
> oooh, same setup and same trace here, but no yum, see some screenshots
> here:
> http://oioio.altervista.org/linux/dsc03448.jpg
> http://oioio.altervista.org/linux/dsc03449.jpg

This is reiser ^^?!, so we can exclude fs? I have this behaviour on ext3.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
