Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285640AbRLGW5M>; Fri, 7 Dec 2001 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285637AbRLGW5D>; Fri, 7 Dec 2001 17:57:03 -0500
Received: from stine.vestdata.no ([195.204.68.10]:30892 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S285635AbRLGW4r>; Fri, 7 Dec 2001 17:56:47 -0500
Date: Fri, 7 Dec 2001 23:56:41 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Nikita Danilov <god@namesys.com>,
        green@thebsh.namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011207235641.B18104@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no> <E16CNHk-0000u4-00@starship.berlin> <20011207174726.B6640@vestdata.no> <3C112E20.2080105@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C112E20.2080105@namesys.com>; from reiser@namesys.com on Sat, Dec 08, 2001 at 12:01:20AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 12:01:20AM +0300, Hans Reiser wrote:
> >In the cases I've studied more closely (e.g. maildir cases) the problem
> >with reiserfs and e.g. the tea hash is that there is no common ordering
> >between directory entries, stat-data and file-data.
> >
> >When new files are created in a directory, the file-data tend to be
> >allocated somewhere after the last allocated file in the directory. The
> >ordering of the directory-entry and the stat-data (hmm, both?) are
> >
> 
> no, actually this is a problem for v3.  stat data are time of creation 
> ordered (very roughly speaking)
> and directory entries are hash ordered, meaning that ls -l suffers a 
> major performance penalty.

Yes, just remember that file-body ordering also has the same problem.
(ref the "find . -type f | xargs cat > /dev/null" test wich I think
represent maildir performance pretty closely)



-- 
Ragnar Kjørstad
Big Storage
