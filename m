Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRB1XLp>; Wed, 28 Feb 2001 18:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRB1XLh>; Wed, 28 Feb 2001 18:11:37 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:60165 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129372AbRB1XKi>;
	Wed, 28 Feb 2001 18:10:38 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2001 23:01:53 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Frank v Waveren <fvw@var.cx>
Cc: Brian Gerst <bgerst@didntduck.org>,
        Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        linux-kernel@vger.kernel.org
Subject: Re: negative mod use count
Message-ID: <20010228230153.A18738@flint.arm.linux.org.uk>
In-Reply-To: <200102281958.UAA13226@falcon.etf.bg.ac.yu> <3A9D5AAB.E9AB4673@didntduck.org> <20010228213146.A1120@var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010228213146.A1120@var.cx>; from fvw@var.cx on Wed, Feb 28, 2001 at 09:31:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 09:31:46PM +0100, Frank v Waveren wrote:
> On Wed, Feb 28, 2001 at 03:08:11PM -0500, Brian Gerst wrote:
> > > what does negative module use count mean?
> > A bugged module.
> 
> Not at all. A non-zero usage count means the module can't be unloaded.
> Whatever the module does with the usage count apart from that is
> completely it's own choice.

A negative module use count (specifically "-1") depends on whether a
module has a "can_unload" routine.  If it does not have a "can_unload"
routine, then chances are either the module decided "I can never be
removed" or else the module is buggy.

However, if a "can_unload" routine does exist (as in ipv6) then the
module use count is unconditionally set to "-1".

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

