Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315969AbSENS2r>; Tue, 14 May 2002 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSENS2q>; Tue, 14 May 2002 14:28:46 -0400
Received: from mark.mielke.cc ([216.209.85.42]:52489 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315969AbSENS2q>;
	Tue, 14 May 2002 14:28:46 -0400
Date: Tue, 14 May 2002 14:23:22 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: elladan@eskimo.com, Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020514142322.C22935@mark.mielke.cc>
In-Reply-To: <200205141753.MAA70930@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't put /var/log on the same file system as /home, and don't grant
access to /var/log to any normal userid.

This isn't 'new'.

mark


On Tue, May 14, 2002 at 12:53:47PM -0500, Jesse Pollard wrote:
> If the root file system is ext2, it does become a security issue since
> currently active logs will continue to record log entries until the
> filesystem is absolutly filled. I should say, if the log device fills up,
> since the log directory is usually /var/log, or /var/adm. Some logs show
> up in etc, but that really depends on the configuration. It IS usefull if the
> filesystem is "full" due to attacks - daemons tend to terminate themselves,
> and their log entry indicates what the problem was. If it is an attack, then
> it's a security issue.
> 
> The only reason it helps fragmentation (subject to actual implementor
> statements) is that the filesystem code will use every scavanged block
> possible under saturation. When the filesystem gets cleand up later,
> these excessively fragmented files will remain, and continue to cause
> access delays.
> 
> Naturally, deleting (or backup/restore) the file(s) cleans up the fragmentation.
> 

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

