Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269393AbRHCPMJ>; Fri, 3 Aug 2001 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRHCPL7>; Fri, 3 Aug 2001 11:11:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269393AbRHCPLn>;
	Fri, 3 Aug 2001 11:11:43 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15210.48950.179949.657793@pizda.ninka.net>
Date: Fri, 3 Aug 2001 08:11:50 -0700 (PDT)
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010803155255.X12470@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>
	<01080219261601.00440@starship>
	<20010803100633.Z12470@redhat.com>
	<01080316082001.01827@starship>
	<20010803155255.X12470@redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen C. Tweedie writes:
 > The word "access" isn't used there in the spec, so it doesn't matter.
 > The spec only refers to "all file system information required to
 > retrieve the data."  Integrity of the data is the only thing
 > guaranteed, not integrity of the namespace.

In fact this interpretation would have a severe performance impact
for any implementation.

If you include "metadata of the 'path'" in "all filesystem
information..." then you have to basically sync each and every element
on the path(s) to that file.  This means walking each dentry in the
alias list for the inode, and then walk from each of those to the root
sync'ing along the way.

That would be a rediculious requirement.

Later,
David S. Miller
davem@redhat.com
