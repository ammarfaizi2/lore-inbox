Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137080AbREKIda>; Fri, 11 May 2001 04:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137079AbREKIdU>; Fri, 11 May 2001 04:33:20 -0400
Received: from ns.suse.de ([213.95.15.193]:6149 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137078AbREKIdI>;
	Fri, 11 May 2001 04:33:08 -0400
Date: Fri, 11 May 2001 10:32:34 +0200
From: Andi Kleen <ak@suse.de>
To: Daniel Podlejski <underley@witch.underley.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010511103233.A2252@gruyere.muc.suse.de>
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <20010510151204.A16686@gruyere.muc.suse.de> <20010510222313Z5297730-750+10@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010510222313Z5297730-750+10@witch.underley.eu.org>; from underley@witch.underley.eu.org on Fri, May 11, 2001 at 12:23:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 12:23:09AM +0200, Daniel Podlejski wrote:
> 
> ext2:
> 
> root@witch:/mobile:# time tar xzf /arc/test.tar.gz

If /arc is not on a different hd it is probably a good idea to make 
sure test.tar.gz is small enough to fit into memory and has been read
at least once to be cache hot (that was the case with my test tar). 
Otherwise you're testing how fast the hd can seek between the two places 
and how far XFS and ext2 are away, and both are not very interesting.


-Andi

