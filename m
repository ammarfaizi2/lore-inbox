Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269405AbRHCPT7>; Fri, 3 Aug 2001 11:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269406AbRHCPTu>; Fri, 3 Aug 2001 11:19:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19472 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269405AbRHCPTk>; Fri, 3 Aug 2001 11:19:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "David S. Miller" <davem@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Date: Fri, 3 Aug 2001 17:25:09 +0200
X-Mailer: KMail [version 1.2]
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010803155255.X12470@redhat.com> <15210.48950.179949.657793@pizda.ninka.net>
In-Reply-To: <15210.48950.179949.657793@pizda.ninka.net>
MIME-Version: 1.0
Message-Id: <01080317250906.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 17:11, David S. Miller wrote:
> Stephen C. Tweedie writes:
>  > The word "access" isn't used there in the spec, so it doesn't matter.
>  > The spec only refers to "all file system information required to
>  > retrieve the data."  Integrity of the data is the only thing
>  > guaranteed, not integrity of the namespace.
>
> In fact this interpretation would have a severe performance impact
> for any implementation.
>
> If you include "metadata of the 'path'" in "all filesystem
> information..." then you have to basically sync each and every element
> on the path(s) to that file.  This means walking each dentry in the
> alias list for the inode, and then walk from each of those to the root
> sync'ing along the way.
>
> That would be a rediculious requirement.

As I read the (excerpts from the) SUS, this isn't required, only that
at least one namespace path from the root to the fsynced file is
preserved.  I can imagine an efficient implementation for this.

--
Daniel
