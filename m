Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316403AbSEWIuF>; Thu, 23 May 2002 04:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316420AbSEWIuE>; Thu, 23 May 2002 04:50:04 -0400
Received: from pc-62-31-74-121-ed.blueyonder.co.uk ([62.31.74.121]:50048 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316403AbSEWIuD>; Thu, 23 May 2002 04:50:03 -0400
Date: Thu, 23 May 2002 09:49:48 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jon Hedlund <JH_ML@invtools.com>, sct@redhat.com, akpm@zip.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Message-ID: <20020523094948.A2462@redhat.com>
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost> <20020523011144.GA4006@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 22, 2002 at 06:11:44PM -0700, Mike Fedyk wrote:
> On Tue, May 21, 2002 at 04:40:06PM -0500, Jon Hedlund wrote:
> > 2. What is the "proper" fix for the patch collision between the raid
> > patch and the ext3 patch in /include/linux/fs.h? 
> 
> Use 2.4.

Actually, you just need to renumber one of the conflicting #defines to
something unused, and it will work fine.  Soft raid0 or linear mode
will work quite happily with ext3 on 2.2 after you do that, it's only
the resync after a crash that you get with raid1 or raid5 that is
dangerous.

Cheers,
 Stephen
