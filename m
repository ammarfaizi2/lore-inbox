Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSJ1G3d>; Mon, 28 Oct 2002 01:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262907AbSJ1G3d>; Mon, 28 Oct 2002 01:29:33 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:47039 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262905AbSJ1G3c> convert rfc822-to-8bit; Mon, 28 Oct 2002 01:29:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Chris Friesen <cfriesen@nortelnetworks.com>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New nanosecond stat patch for 2.5.44
Date: Sun, 27 Oct 2002 20:35:47 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021027121318.GA2249@averell> <aphqqo$261$1@cesium.transmeta.com> <3DBC9194.5090006@nortelnetworks.com>
In-Reply-To: <3DBC9194.5090006@nortelnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210271935.47252.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 19:23, Chris Friesen wrote:
> H. Peter Anvin wrote:
> > We probably need to revamp struct stat anyway, to support a larger
> > dev_t, and possibly a larger ino_t (we should account for 64-bit ino_t
> > at least if we have to redesign the structure.)  At that point I would
> > really like to advocate for int64_t ts_sec and uint32_t ts_nsec and
> > quite possibly a int32_t ts_taidelta to deal with leap seconds... I'd
> > personally like struct timespec to look like the above everywhere.
>
> For filesystems can we get away with just the 64-bit nanoseconds?  By my
> calculations that gives something like 584 years--do we need to worry
> about files older than that?

1) The hard drive is only about 50 years old, so there aren't any files older 
than that at the moment:
http://www.mdhc.scu.edu/100th/reyjohnson.htm

2) This thing is unlikely to be a problem in our lifetimes, our 
grandchildren's lifetimes, or our great grandchildren's lifetimes (barring 
unforseen advances in active telomere reconstruction and a regenerative 
interpretation of DNA that somehow looks at it as a blueprint rather than a 
recipe).

3) If any current hardware or software is still in use in the year 2554, it 
will be seriously overdue for an upgrade.

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
