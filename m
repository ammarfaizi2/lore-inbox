Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945897AbWBCTOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945897AbWBCTOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945901AbWBCTOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:14:22 -0500
Received: from mail.gmx.net ([213.165.64.21]:48012 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945897AbWBCTOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:14:21 -0500
X-Authenticated: #428038
Date: Fri, 3 Feb 2006 20:14:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, cdwrite@other.debian.org, acahalan@gmail.com
Subject: Re: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203191415.GA18533@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org, cdwrite@other.debian.org,
	acahalan@gmail.com
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203182049.GB11083@merlin.emma.line.org> <43E3A19E.nail6A511N92B@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E3A19E.nail6A511N92B@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-03:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > So patches to the rescue -- please review the patch below (for 2.01.01a05).
> > Note that GPL 2a and 2c apply, so you cannot merge a modified version of
> > my patch without adding a tag that you goofed my fixes.
> 
> OK, I did not look at it and I never will!

Perhaps you should -- the patch impairs your changes to get
needless device enumeration changes into the kernel...

Enforcing your strict interpretation of GPL v2 §§ 2a, 2c to the letter
was your own idea. I had to touch "modification prohibited" sections to
remove obsolete (bogus) warnings.

I'll amend the license: Show me your integrated patch. If it works
properly on my computer and without false warnings, you add a note to
the changelog and the AN-2.01.01a06 file, I will demote the patch's
license to the MIT license as in
<http://opensource.org/licenses/mit-license.php>. Yes, this is a license
contract offer as per the BGB. Just write you're accepting it, or accept
implicitly by sending the integration patch against 2.01.01a05.

I just want to make sure that it doesn't bear my name if the integration
breaks it again.

The code can probably be simplified even more with readdir() on /dev and
filtering it (avoiding glob() buffer issues), my patch doesn't even
attempt to do that.

And if you explain the use of LF_ATA, the kernel drivers might even be
fixes so that /dev/hd* looks confusably similar to /dev/sg*.

-- 
Matthias Andree
