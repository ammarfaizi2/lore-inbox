Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbSJWPMh>; Wed, 23 Oct 2002 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265045AbSJWPMh>; Wed, 23 Oct 2002 11:12:37 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:9111 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265038AbSJWPMf> convert rfc822-to-8bit;
	Wed, 23 Oct 2002 11:12:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Nivedita Singhvi <niv@us.ibm.com>, bert hubert <ahu@ds9a.nl>
Subject: O_DIRECT sockets? (was [RESEND] tuning linux for high network performance?)
Date: Wed, 23 Oct 2002 17:26:21 +0200
User-Agent: KMail/1.4.1
Cc: netdev@oss.sgi.com, Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl> <3DB6B96F.A0DE47BF@us.ibm.com>
In-Reply-To: <3DB6B96F.A0DE47BF@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231726.21135.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 16:59, Nivedita Singhvi wrote:
> bert hubert wrote:
> > > ...adding the whole profile output - sorted by the first column this
> > > time...
> > >
> > > 905182 total                                      0.4741
> > > 121426 csum_partial_copy_generic                474.3203
> > >  93633 default_idle                             1800.6346
> > >  74665 do_wp_page                               111.1086
> >
> > Perhaps the 'copy' also entails grabbing the page from disk, leading to
> > inflated csum_partial_copy_generic stats?
>
> I think this is strictly a copy from user space->kernel and vice versa.
> This shouldnt include the disk access etc.

hm

I'm doing O_DIRECT read (from disk), so it needs to be user -> kernel, then.

any chance of using O_DIRECT to the socket?

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

