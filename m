Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSGDWDD>; Thu, 4 Jul 2002 18:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSGDWDC>; Thu, 4 Jul 2002 18:03:02 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:53426 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314459AbSGDWDC>; Thu, 4 Jul 2002 18:03:02 -0400
Date: Fri, 5 Jul 2002 00:05:11 +0200
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020704220511.GA4728@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	LKML <linux-kernel@vger.kernel.org>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de> <20020702131314.B4711@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702131314.B4711@redhat.com>
User-Agent: Mutt/1.4i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 01:13:14PM +0100, Stephen C. Tweedie wrote:
> On Fri, Jun 28, 2002 at 11:59:42PM +0200, Daniel Kobras wrote:
> > Or is there a
> > way to flush the current queue of transactions, eg. by fsync()ing the
> > underlying block device, or by sending a magic signal to kjournald? 
> 
> an fsync() on any file or directory on the filesystem will ensure that
> all old transactions have completed, and a sync() will ensure that any
> old transactions are at least on their way to disk.

With emphasis on 'on the filesystem', I suppose?  In other words, if we
have an ext3 fs on /dev/hda1 mounted on /mnt, it is not sufficient to
fsync("/dev/hda1") to flush the transactions, but fsync("/mnt") will do?
(Excuse the sloppy notation.)

Regards,

Daniel.

