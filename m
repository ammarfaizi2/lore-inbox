Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263975AbRFHLsb>; Fri, 8 Jun 2001 07:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263987AbRFHLsW>; Fri, 8 Jun 2001 07:48:22 -0400
Received: from penguin.eunet.cz ([193.86.255.66]:36616 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S263978AbRFHLsO>; Fri, 8 Jun 2001 07:48:14 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Fri, 8 Jun 2001 13:48:02 +0200
To: linux-kernel@vger.kernel.org, xgajda@fi.muni.cz, kron@fi.muni.cz
Subject: Re: CacheFS
Message-ID: <20010608134802.H1100@informatics.muni.cz>
In-Reply-To: <20010607133750.I1193@informatics.muni.cz> <20010607114419.A23962@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010607114419.A23962@cs.cmu.edu>; from jaharkes@cs.cmu.edu on Thu, Jun 07, 2001 at 11:44:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
: > 	Every file on the front filesystem (NFS or so) volume will be cached
: > in two local files by cachefsd: The first one would contain the (parts of)
: > real file content, and the second one would contain file's metadata and the
: > bitmap of valid blocks (or pages) of the first file. All files in cachefsd's
: > backing store would be in a per-volume directory, and will be numbered by the
: > inode number from the front filesystem.
: 
: - Intermezzo uses 'holes' in files to indicate that content isn't
:   available.

	Well, but can you see the hole from the user-space daemon?

: - You might want to have a more hierarchical backing store, directory
:   operations in large directories are not very efficient.

	Yes, of course. But this is an implementation detail of cachefsd.

: - I believe you are switching the meaning of front and backend
:   filesystems around a lot in your description. Who exactly assigns the
:   inode numbers?

	Well, let's speak about NFS, locally cached on ext2. The present
implemetation takes inode number from NFS, and creates and ext2 file
named - for example - /cache/%d (for file contents) and  /cache/%d.attr for
stat(2) data and valid blocks bitmap. The %d is an inode number from the
NFS volume.

: Some references,
: 
: UserFS, PodFuk, AVFS,

	Thanks,

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
It is a very bad idea to feed negative numbers to memcpy.         --Alan Cox
