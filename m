Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSBST5I>; Tue, 19 Feb 2002 14:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289581AbSBST4x>; Tue, 19 Feb 2002 14:56:53 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:41459 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288987AbSBST4l>;
	Tue, 19 Feb 2002 14:56:41 -0500
Date: Tue, 19 Feb 2002 12:56:22 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jakob Kemi <jakob.kemi@telia.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conve
Message-ID: <20020219125622.B25713@lynx.adilger.int>
Mail-Followup-To: Jakob Kemi <jakob.kemi@telia.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <02021919474003.00447@jakob>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02021919474003.00447@jakob>; from jakob.kemi@telia.com on Tue, Feb 19, 2002 at 07:47:40PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2002  19:47 +0100, Jakob Kemi wrote:
> We needed the code when parsing non-null terminated UUID strings in the LDM
> partition database (Dynamic Disks). And sscanf wouldn't work for us. Consider:
> 
> char a[3] = {'a','b'};
> char b[3] = {'a','-'};
> int x;
> sscanf(a, "%x", &x);  // undefined, could crash since a isn't null-terminated

If it is a matter of UUID parsing, just add (or use existing) function
uuid_parse() similar to that in libuuid.  Some UUID-related functions were
added to the kernel for ia64 GPM partitions, so this would just make the
UUID support in the kernel more complete.

Note that unless LDM has some serious brain-damage, there should not be any
need to have these special functions, as the user-space UUID-related code
works just fine without them.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

