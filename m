Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281544AbRKUEZH>; Tue, 20 Nov 2001 23:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRKUEY5>; Tue, 20 Nov 2001 23:24:57 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:53753 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281544AbRKUEYs>;
	Tue, 20 Nov 2001 23:24:48 -0500
Date: Tue, 20 Nov 2001 21:23:36 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: =?iso-8859-1?Q?H=E5vard_Kv=E5len?= <havardk@netcom.no>
Cc: Dan Maas <dmaas@dcine.com>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap
Message-ID: <20011120212336.H1308@lynx.no>
Mail-Followup-To: =?iso-8859-1?Q?H=E5vard_Kv=E5len?= <havardk@netcom.no>,
	Dan Maas <dmaas@dcine.com>, Rik van Riel <riel@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111202019170.4079-100000@imladris.surriel.com> <03bb01c17213$887ccd30$1a01a8c0@allyourbase> <fa.jc73ejv.1s6e80t@ifi.uio.no> <m3wv0knbgs.fsf@athlon.kvaalen.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <m3wv0knbgs.fsf@athlon.kvaalen.no>; from havardk@netcom.no on Wed, Nov 21, 2001 at 02:45:23AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 21, 2001  02:45 +0100, Håvard Kvålen wrote:
> > (I just tried looking at XMMS and Freeamp - I *think* they are using
> > read(), but strace seems to do bad things with threaded programs,
> > argh...)
> 
> You are right about XMMS, it uses read().  I'm not sure about Freeamp.

When I was hacking on mpg123, it was using mmap by default unless it was
unable to mmap the file (e.g. stdin) where it uses read.  You could turn
this off at compile time, so it only uses read.  I found that to work
better on low memory machines.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

