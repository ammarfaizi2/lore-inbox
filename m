Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314367AbSDRSO6>; Thu, 18 Apr 2002 14:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314399AbSDRSO5>; Thu, 18 Apr 2002 14:14:57 -0400
Received: from borg.org ([208.218.135.231]:64906 "HELO borg.org")
	by vger.kernel.org with SMTP id <S314367AbSDRSO5>;
	Thu, 18 Apr 2002 14:14:57 -0400
Date: Thu, 18 Apr 2002 14:14:56 -0400
From: Kent Borg <kentborg@borg.org>
To: linux-kernel@vger.kernel.org
Cc: "Kerl, John" <John.Kerl@Avnet.com>, "'Lars Marowsky-Bree'" <lmb@suse.de>
Subject: Re: Versioning File Systems?
Message-ID: <20020418141456.A16866@borg.org>
In-Reply-To: <C08678384BE7D311B4D70004ACA371050B7633CA@amer22.avnet.com> <20020418172419.GA433@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 12:24:19PM -0500, Florin Iucha wrote:
> http://www.netcraft.com.au/geoffrey/katie/

Very interesting.  

Looking at the docs that come in the sources Katie appears to be
(mostly) perl code that stores its data in Postgresql and uses NFS to
loop it back as filesystem of normal looking files, hidden directories
for access to old versions, and command a line program for doing all
other CVS-ish functions.

Glad to see there is such a nice conceptual testbed for what I was
looking for, but this isn't it directly.  

Am I crazy or would it be possible to create a versioning file system
on the model of the cannonical ext2?  It would sit on top of a rather
stupid block device and present something that, at first glance, looks
like a traditional filesystem.  A complete superset, create a file by
creating a file, read a file by reading a file, delete a file by
deleting a file, and make it all happen at a low enough level to boot
from it even.

The extra features would, of course, need additional means for access;
I don't know the ramifications of a such a complete filesystem having
such things like extra hidden-ish directories for accessing old
versions.  (I worry about standard utilities tripping over virtual
contents--I know that /proc and /dev do strange things when I forget
and pretend they are simply files.)


-kb
