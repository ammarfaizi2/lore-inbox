Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRJBIxC>; Tue, 2 Oct 2001 04:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275971AbRJBIww>; Tue, 2 Oct 2001 04:52:52 -0400
Received: from mail.zmailer.org ([194.252.70.162]:17420 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S275963AbRJBIwk>;
	Tue, 2 Oct 2001 04:52:40 -0400
Date: Tue, 2 Oct 2001 11:53:02 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'dd' local works, but not over net, help as to why?
Message-ID: <20011002115302.L1144@mea-ext.zmailer.org>
In-Reply-To: <20011002112005.K1144@mea-ext.zmailer.org> <NDBBJDKDKDGCIJFBPLFHAEKACGAA.law@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NDBBJDKDKDGCIJFBPLFHAEKACGAA.law@sgi.com>; from law@sgi.com on Tue, Oct 02, 2001 at 01:35:28AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 01:35:28AM -0700, LA Walsh wrote:
> >    You are missing one 'dd' from the other system side, but
> >    are you also sure that the remote system can support large
> >    files, and that the dd in there does support large files ?
> ---
> 	Missing 'dd' typo.  It's on the other system I tried copying the 8G
> to a slightly large 9G partition -- that worked.  On the source system
> I can copy 8G to another 8G partition.  Just running them over rsh seems to
> be a problem.  Same version of 'dd' on each side (SuSE 7.2).

   There could be something amiss in the dd when feeding into a pipe
   ( 2G limit should not matter, but...)  

   Try following:

	dd if=/dev/sdX | cat > /dev/null

   Hmm..  And also:

	dd if=/dev/sdX | rsh other-host dd of=/dev/null


> 	Maybe I can fool ftp with symlinks tomorrow into doing the copy and see
> if that works.  Just for fun I tried 'cat' as well -- same error -- out of
> space on target.

	'cat' local or remote ?
 
> It transfers a lot of data -- right around 2G the first time I tried it, so
> it looked awfully suspicious.

	Yes, suspicuous about something in the rsh barfing.

> Linda

/Matti Aarnio
