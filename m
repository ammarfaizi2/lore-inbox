Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbUB1O73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUB1O72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:59:28 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:4513 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S261898AbUB1O7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:59:14 -0500
Subject: Re: 2.6.x: iowait problem while burning a CD
From: Alex Bennee <kernel-hacker@bennee.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200402281014.19842.ornati@fastwebnet.it>
References: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com>
	 <200402281014.19842.ornati@fastwebnet.it>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1077979936.2791.69.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Sat, 28 Feb 2004 14:52:16 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 09:14, Paolo Ornati wrote:
> On Saturday 28 February 2004 01:18, Rik van Riel wrote:
> > On Fri, 27 Feb 2004, Paolo Ornati wrote:
> > > trying to burn a CD "on the fly" I have noticed a strange thing. During
> > > the burning "iowait" remains enough low (~3%, MAX 10%) but, after a
> > > little time, it suddenly and quickly goes up to 80-90%: in this
> > > condition MKFS seems unable to fill the FIFO buffer as quickly as the
> > > CD-writer writes
> > >
> > > Any ideas?
> >
> > At that point, mkisofs is probably running into a bazillion
> > small files, in subdirectories all over the place.
> >
> > Because a disk seek + track read takes 10ms, it's simply not
> > possible to read more than maybe 100 of these small files a
> > second, so mkisofs can't keep up.
> 
> No... mkfs is reading only ONE big file ( ~ 700 MB )!
> 
> And my system shouldn't be so slow:
> 
> CPU: AMD Duron 750
> RAM: 128 MB PC100
> HD: 7200 RPM udma 4
> File System: ResiserFS

Could this be related to your low(ish) physical memory and the need swap
stuff in and out? Maybe you could look at the vmstat output as you run
the two cases?

-- 
Alex, homepage: http://www.bennee.com/~alex/
"Everything should be made as simple as possible, but not simpler."
-- Albert Einstein

