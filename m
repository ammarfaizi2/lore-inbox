Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132154AbRCVTH1>; Thu, 22 Mar 2001 14:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132153AbRCVTHS>; Thu, 22 Mar 2001 14:07:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:43974 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132154AbRCVTHH>;
	Thu, 22 Mar 2001 14:07:07 -0500
Date: Thu, 22 Mar 2001 19:04:52 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, Alexander Viro <viro@math.psu.edu>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: 2.4.2 fs/inode.c
Message-ID: <20010322190452.C7756@redhat.com>
In-Reply-To: <20010322134215.A25508@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010322134215.A25508@cs.cmu.edu>; from jaharkes@cs.cmu.edu on Thu, Mar 22, 2001 at 01:42:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 22, 2001 at 01:42:15PM -0500, Jan Harkes wrote:
> 
> I found some code that seems wrong and didn't even match it's comment.
> Patch is against 2.4.2, but should go cleanly against 2.4.3-pre6 as well.
 
Patch looks fine to me.  Have you tested it?  If this goes wrong,
things break badly...

>  		/* Don't do this for I_DIRTY_PAGES - that doesn't actually dirty the inode itself */
> -		if (flags & (I_DIRTY | I_DIRTY_SYNC)) {
> +		if (flags & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {

--Stephen
