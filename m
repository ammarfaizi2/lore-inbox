Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSLHRPl>; Sun, 8 Dec 2002 12:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLHRPl>; Sun, 8 Dec 2002 12:15:41 -0500
Received: from users.linvision.com ([62.58.92.114]:5013 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S261354AbSLHRPk>; Sun, 8 Dec 2002 12:15:40 -0500
Date: Sun, 8 Dec 2002 18:23:03 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make `hash_long' function work if bits parameter is 0.
Message-ID: <20021208182303.A10485@bitwizard.nl>
References: <20021206093351.9413736F6@mcspd15.ucom.lsi.nec.co.jp> <Pine.LNX.4.44.0212060836170.23118-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212060836170.23118-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 08:37:26AM -0800, Linus Torvalds wrote:
> On Fri, 6 Dec 2002, Miles Bader wrote:
> >
> > If the bits parameter of hash_long (in <linux/hash.h>) is 0, then it
> > ends up right-shifting by BITS_PER_LONG, which is undefined in C (and
> > often is a nop).
> 
> I would much rather just add a comment saying that "bits" had better be in
> a valid range. There are no valid uses for a 0-bit hash table that I can
> see, and undefined behaviour for undefined operations is fine with me.

Wouldn't it be nice to have a memory-for-speed tradeoff by being able
to set the bits-in-the-hash-table to zero?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
