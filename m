Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281037AbRKCUrX>; Sat, 3 Nov 2001 15:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281042AbRKCUrM>; Sat, 3 Nov 2001 15:47:12 -0500
Received: from are.twiddle.net ([64.81.246.98]:7866 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S281039AbRKCUq7>;
	Sat, 3 Nov 2001 15:46:59 -0500
Date: Sat, 3 Nov 2001 12:46:57 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre6 BUG oops
Message-ID: <20011103124657.C5984@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BE03401.406B8585@mandrakesoft.com> <20011031.094112.125896630.davem@redhat.com> <9rpfbj$vrn$1@penguin.transmeta.com> <3BE04338.8F0AF9D4@mandrakesoft.com> <9rpks1$bk$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9rpks1$bk$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 31, 2001 at 07:53:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 07:53:37PM +0000, Linus Torvalds wrote:
> I wonder if the "VALID_PAGE(page)" macro is reliable on alpha? You seem
> to be able to trigger this too easily for it to not being something
> specific to the setup..

Should be.  I've never seen an alpha with discontiguous memory.
(Well, I've not looked at a numa box, but that's not at issue here.)

FWIW, we dump the HWRPB memory table early in the boot process, e.g.

memcluster 0, usage 1, start        0, end      192
memcluster 1, usage 0, start      192, end    16267
memcluster 2, usage 1, start    16267, end    16384

where "usage 1" is reserved by the console.


r~
