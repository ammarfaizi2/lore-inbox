Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSGCDtV>; Tue, 2 Jul 2002 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGCDtU>; Tue, 2 Jul 2002 23:49:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35602 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316786AbSGCDtU>;
	Tue, 2 Jul 2002 23:49:20 -0400
Message-ID: <3D227621.B0A5C826@zip.com.au>
Date: Tue, 02 Jul 2002 20:57:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
References: <20020703022051.GA2669@lnuxlab.ath.cx> <3D226E86.695D27F3@zip.com.au> <20020703033538.GA3004@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> On Tue, Jul 02, 2002 at 08:24:54PM -0700, Andrew Morton wrote:
> >khromy wrote:
> >>
> >>When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2 minutes.
> >>When I copy the same file to /usr/local/, sync returns almost right away.
> >
> >Gad.  Please, mount those filesystems as ext2 and retest.
> 
> I just did, same exact behavior.. Anything else?
> 

Possibly what is happening is that the /tmp partition lies on
a part of the disk which has a higher platter transfer speed
and this higher speed is causing retries or other problems
further down the chain.

You could have a fiddle with hdparm, try slowing down the
interface speed.  Try a different set of cables, too.

-
