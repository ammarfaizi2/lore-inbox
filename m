Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932756AbWAHSri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbWAHSri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWAHSrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:47:37 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:12498 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932756AbWAHSrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:47:33 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 08/41] m68k: fix macro syntax to make current binutils happy
Date: Sun, 8 Jan 2006 18:11:55 +0100
User-Agent: KMail/1.8.2
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
References: <E1EtvYX-0003Lo-Gf@ZenIV.linux.org.uk> <20060105035118.GS27946@ftp.linux.org.uk> <20060105113708.GT27946@ftp.linux.org.uk>
In-Reply-To: <20060105113708.GT27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081811.58669.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 05 January 2006 12:37, Al Viro wrote:

> > OK.  Nothing else depends on those; however, getuser.l stuff _is_
> > documented.

It actually was a nice feature and what I have seen so far look like bad 
regression and makes the gas macros totally useless. Before it was possible 
to define some pseudo assembly instructions, but if one can't pass some 
simple address operand without quotes as an argument anymore...

> > Frankly, my preference long-term would be to kill the .macro and just
> > use C preprocessor for expansion.  Do you have any objections against
> > such variant?
>
> Scratch that; too much PITA to implement the horrors you've got there
> (vararg recursive macros <shudder>).

Well, at that the time I wrote it, it very nicely cleaned up the old code 
(which was even worse) and made additions very simple. The recursive macros 
avoided a lot of simple typos. I'm not really happy that I have to change 
that, it worked fine so far.
BTW I'm back in a few days and my online connectivity is rather limited right 
now, so I hadn't really a good possibility to research the possible options 
yet.

bye, Roman

