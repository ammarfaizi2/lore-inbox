Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSFUOy5>; Fri, 21 Jun 2002 10:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSFUOy4>; Fri, 21 Jun 2002 10:54:56 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:39751 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S316593AbSFUOy4>; Fri, 21 Jun 2002 10:54:56 -0400
Date: Fri, 21 Jun 2002 17:54:51 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020621145451.GA1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Andreas Dilger <adilger@clusterfs.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020620103429.A2464@redhat.com> <20020620101812.GL22427@clusterfs.com> <E17L2G0-00019Q-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17L2G0-00019Q-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 03:45:51PM +0200, you [Daniel Phillips] wrote:
> 
> And in the accidental-untar case that started this thread, Raul would
> have the same complaint: a directory bloats up and never unbloats
> until completely emptied.

Not only accidental untar, but buggy progs as well. Recently, I found out
that named had created tens of thousands of (luckily zero-length) files in a
single dir on ext2. While it only took couple of hours to delete them with
"find . -name '...'| xargs -n 5000 rm" commands, I can imagine remote DOS
attacks through daemons that create local temp files. Accessing such
directory quickly becomes slow as molasses on ext2.

Daniels patch seems great. I also recall someone (Ted T'so? Stephen Tweedie?)
had another dir access speed-up patch for ext3... Is that applicable to ext2
or was it already merged?


-- v --

v@iki.fi
