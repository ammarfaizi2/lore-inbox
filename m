Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTAHHvo>; Wed, 8 Jan 2003 02:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267764AbTAHHvo>; Wed, 8 Jan 2003 02:51:44 -0500
Received: from [212.71.168.94] ([212.71.168.94]:48077 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S267761AbTAHHvn>; Wed, 8 Jan 2003 02:51:43 -0500
Date: Wed, 8 Jan 2003 09:00:05 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Max Valdez <maxvaldez@yahoo.com>, Jan Hudec <bulb@ucw.cz>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: Undelete files on ext3 ??
Message-ID: <20030108080005.GK2141@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Gerhard Mack <gmack@innerfire.net>,
	Andreas Dilger <adilger@clusterfs.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Max Valdez <maxvaldez@yahoo.com>,
	kernel <linux-kernel@vger.kernel.org>
References: <20030107115544.W31555@schatzie.adilger.int> <Pine.LNX.4.44.0301080000250.18804-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301080000250.18804-100000@innerfire.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 12:01:34AM -0500, Gerhard Mack wrote:
> On Tue, 7 Jan 2003, Andreas Dilger wrote:
> 
> > Date: Tue, 7 Jan 2003 11:55:44 -0700
> > From: Andreas Dilger <adilger@clusterfs.com>
> > To: Richard B. Johnson <root@chaos.analogic.com>
> > Cc: Max Valdez <maxvaldez@yahoo.com>, Jan Hudec <bulb@ucw.cz>,
> >      kernel <linux-kernel@vger.kernel.org>
> > Subject: Re: Undelete files on ext3 ??
> >
> > On Jan 07, 2003  13:17 -0500, Richard B. Johnson wrote:
> > > Therefore, it's time for somebody to put a 'dumpster` in all the Linux
> > > file-systems.  Somebody should then modify `rm` and the kernel unlink
> > > to `mv' files to the dumpster directory on the file-system, instead of
> > > really deleting them. Then, just like the Redmond stuff, a separate
> > > program can be used to clear out the "dumpster" or `mv` them back.
> >
> > This is very FAQ.  Please see the l-k archives for any year to find
> > lengthy discussions about this.
> >
> 
> Funny my gnome2 install has a wastebasket and last I checked if you open a
> command shell in windows and del *.* you are screwed anyhow.
> 
> So we have exactly the same functionality windows does.

Yes. But we could do better. Since no program uses the __syscall
interface directly, wraping unlink in libc would affect all programs
including rm. It could even be done withou recompiling anything using
LD_PRELOAD.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
