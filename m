Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSK0Dr6>; Tue, 26 Nov 2002 22:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSK0Dr6>; Tue, 26 Nov 2002 22:47:58 -0500
Received: from bozo.vmware.com ([65.113.40.131]:60679 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261544AbSK0Dr5>; Tue, 26 Nov 2002 22:47:57 -0500
Date: Tue, 26 Nov 2002 18:59:44 -0800
From: chrisl@vmware.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021127025944.GC1519@vmware.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsptsrd761.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure that is going to help or not:

Htree readdir will return the file position bigger than the
real size of directory, it  stores the hash information in lower
bits.

I just go though the source code, haven't find out how NFS
handle that yet.

Yes. Print out cookies will help.

Chris

On Wed, Nov 27, 2002 at 04:26:46AM +0100, Trond Myklebust wrote:
> >>>>> " " == Jeremy Fitzhardinge <jeremy@goop.org> writes:
> 
>      > It looks to me like some sort of problem managing the NFS
>      > readdir cookies, but it isn't clear to me whether this is the
>      > NFS server/ext3 generating bad cookies, or the NFS client
>      > handling them wrongly.
> 
> In order to determine which of the two needs to be fixed, it would
> help if you could print out the cookies from that listing or better
> still: if you could provide us with the raw tcpdump output. Please
> remember to use an 8k snaplen for the tcpdump...
> 
> Cheers,
>   Trond
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Get the new Palm Tungsten T 
> handheld. Power & Color in a compact size! 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel


