Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135716AbRD2LTh>; Sun, 29 Apr 2001 07:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135717AbRD2LT2>; Sun, 29 Apr 2001 07:19:28 -0400
Received: from www.linux.org.uk ([195.92.249.252]:5135 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S135716AbRD2LTP>;
	Sun, 29 Apr 2001 07:19:15 -0400
Date: Sun, 29 Apr 2001 12:18:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy implementation issues
Message-ID: <20010429121841.F30243@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk> <15083.40318.158099.137018@pizda.ninka.net> <20010429072342.B30041@flint.arm.linux.org.uk> <15083.52835.992666.897323@pizda.ninka.net> <20010429101739.D30243@flint.arm.linux.org.uk> <20010429113122.E30243@flint.arm.linux.org.uk> <15083.62888.860815.889046@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15083.62888.860815.889046@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 29, 2001 at 04:06:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 04:06:16AM -0700, David S. Miller wrote:
> I understand that you are frustruated about this and it
> requires you to touch some delicate assembly.  But I'm
> going to be blunt and say "tough", because everyone has
> to implement this correctly.  Just do it and get it
> over with.

I'm doing it _NOW_, but I'm having to rotate the checksum
at the end if dst & 1, only to have it unrotated in an
inefficient manner in csum_block_*.  Seems a bit of a
waste of CPU cycles.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

