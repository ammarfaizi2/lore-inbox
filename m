Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVCCBp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVCCBp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVCCB1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:27:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261415AbVCCB1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:27:24 -0500
Date: Wed, 2 Mar 2005 20:27:07 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303012707.GK10124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
	jgarzik@pobox.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302172049.72a0037f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 05:20:49PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > So what was broken with the 2.6.8.1 type of 'hotfix kernel' release ?
 > 
 > That's an alternative, of course.
 > 
 > But that _is_ a branch, and does need active forward- and (mainly)
 > backward-porting work.
 > 
 > There's nothing wrong with it per-se, but it becomes a "stabilised version
 > of the kernel.org tree" or even a "production version of the kernel.org
 > tree".  In other words it's somewhere on the line between the mainline
 > kernel.org tree and a distribution.  How far along that line should it
 > be positioned?

In an ideal world, we'd see a single 'y' release of 2.6.x.y, but if x+1 takes
too long to be released, bits of x+1 should also appear in x.y+1
The only question in my mind is 'how critical does a bug have to be to
justify a .y release.  Once a new 'x' release comes out, the previous x.y
would likely no longer get any further fixes (unless someone decides the
new 'x' sucked so bad).

Linus using bitkeeper should actually remove most of the pain from this
multiple branch thing though. If fixes alternatively get checked into x.y
and new development goes into x+1, x+1 could do a daily pull of x.y
Thus saving the having to check in fixes to two seperate branches.
(which really really sucks under some SCMs).

		Dave

