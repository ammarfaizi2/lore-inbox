Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSEIKff>; Thu, 9 May 2002 06:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315691AbSEIKfe>; Thu, 9 May 2002 06:35:34 -0400
Received: from c17997.eburwd3.vic.optusnet.com.au ([210.49.198.98]:30454 "HELO
	satisfactory.karma") by vger.kernel.org with SMTP
	id <S315690AbSEIKfd>; Thu, 9 May 2002 06:35:33 -0400
Date: Thu, 9 May 2002 20:35:24 +1000
From: Andrew Clausen <clausen@gnu.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Evms-announce] [ANNOUNCE] EVMS Release 1.0.1
Message-ID: <20020509103524.GC1137@gnu.org>
In-Reply-To: <02050810181004.26176@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 10:18:10AM -0500, Kevin Corry wrote:
> The EVMS team is announcing the next full release of the Enterprise Volume 
> Management System. Package 1.0.1 is now available for download at the project 
> web site:
> http://www.sf.net/projects/evms
> Version 1.0.1 is primarily minor bug fixes for the previous version (1.0.0), 
> as noted below.
> 
> This release again contains an extra package for experimental File System 
> Interface Module (FSIM) support. Along with the libparted-based FSIM, there 
> is also a new JFS FSIM. The parted FSIM requires parted version 1.6.x, and 
> the JFS FSIM requires version 1.0.9 or later of the JFS utilities.

It would be nice if the jfs fsim linked against libjfs, rather than
exec()ing mkfs & friends.

(mkfs should be a frontend of libjfs)

Notice you have no error handling, etc. now?   Also, the "total system"
seems more complicated now.  (For example: how are you going to
interface the resizer, so you can find out the min/max sizes, etc?)

Also, while I'm at it: you didn't like my idea for interfacing
the parted exception system with evms properly?  I even wrote the code
for you (without testing it)... I didn't see a reply to my mail...
you(s) didn't like it?

BTW: what do you think of how libparted interfaces with libreiserfs?
There has been a lot of work, and it has all been merged properly now.
I think EVMS should do something similar.  Have a look in
libparted/fs_reiserfs.

Andrew

