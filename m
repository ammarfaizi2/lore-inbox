Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRD2KcO>; Sun, 29 Apr 2001 06:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbRD2KcE>; Sun, 29 Apr 2001 06:32:04 -0400
Received: from www.linux.org.uk ([195.92.249.252]:29194 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S131460AbRD2Kb6>;
	Sun, 29 Apr 2001 06:31:58 -0400
Date: Sun, 29 Apr 2001 11:31:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Zerocopy implementation issues
Message-ID: <20010429113122.E30243@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk> <15083.40318.158099.137018@pizda.ninka.net> <20010429072342.B30041@flint.arm.linux.org.uk> <15083.52835.992666.897323@pizda.ninka.net> <20010429101739.D30243@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429101739.D30243@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Apr 29, 2001 at 10:17:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 10:17:39AM +0100, Russell King wrote:
> On Sun, Apr 29, 2001 at 01:18:43AM -0700, David S. Miller wrote:
> > Occaisionally I find that sparc64 is making a gross error or invalid
> > assumption, and I accept this and fix it up.
> 
> Ok, I see precisely what's going on here now, shame you didn't explain
> about these csum_add stuff in your first mail on this subject, and
> we could've saved going down this path.
> 
> I'll fix up the ARM code, but its not going to be nice.

David,

Would it be acceptable to have csum_block_* in the architecture
specific code?

Firstly, architecture specific code can optimise them more
efficiently, and secondly it will prevent checksum rotations in
the architecture specific code which will only get undone by
the csum_block_* code.

Or am I missing something?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

