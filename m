Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281861AbRK1LMo>; Wed, 28 Nov 2001 06:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281880AbRK1LMe>; Wed, 28 Nov 2001 06:12:34 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48136 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S281861AbRK1LMa>; Wed, 28 Nov 2001 06:12:30 -0500
Message-ID: <3C04C65D.5614D04A@idb.hist.no>
Date: Wed, 28 Nov 2001 12:11:25 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mark Richards <richard@ecf.utoronto.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca> <3C036A83.F23E6EBE@idb.hist.no> <3C03A702.EBE823C9@ecf.utoronto.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Richards wrote:
[...]
> I'll look into Coda, but ideally I wouldn't have to copy each file to the local
> workstation when I use it, only when it is reserved for editing.  Also, I'd like to
> be able to store the local copy anywhere on the filesystem, if possible.

Worried your drive will fill up?  The files copied to your
drive is merely copied as a "caching" operation.  They
still seem to reside at the server - this is totally transparent.
And of course you can limit this caching - if too many files
is cached some is simply thrown away.  (Or sent back
if they were changed.) They will be re-
loaded automatically if you ever need them again.

If you really want to store them where you want instead of
transparent access, why bother with a new FS at all?
(I believe coda lets you specify where the caching
will happen, if you have several partitions/drives)

Simply run a script that reserves the file (by using
the permission system) and *copy* it to
where you want.  Check-in will consist of copying
the altered file back, and restore normal permissions.

You might even want to run a system like CVS, unless
there is some special reason for not doing that.

Helge Hafting
