Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbUKRSU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbUKRSU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbUKRSBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:01:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8090 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262834AbUKRSBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:01:06 -0500
Date: Thu, 18 Nov 2004 18:01:00 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Matthew Wilcox <willy@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
Message-ID: <20041118180100.GR26623@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041118172606.GA6729@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411180956290.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411180956290.2222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 09:59:00AM -0800, Linus Torvalds wrote:
> Nope. It got fixed differently: by only adding POSIX locks to the list. 
> See locks_insert_block(). Since a non-posix lock cannot be blocked by a 
> POSIX lock, the "if (IS_POSIX(blocker))" test should make sure we're 
> always proper.
> 
> At least that's Willy claims. If you think he's wrong, holler.
> 
> Willy Cc'd, once more.

The problem certainly should have been fixed.  I'd like to know if it
still occurs.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
