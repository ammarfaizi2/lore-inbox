Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135773AbREFRJA>; Sun, 6 May 2001 13:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135786AbREFRIv>; Sun, 6 May 2001 13:08:51 -0400
Received: from www.linux.org.uk ([195.92.249.252]:40462 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S135773AbREFRIk>;
	Sun, 6 May 2001 13:08:40 -0400
Date: Sun, 6 May 2001 18:08:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 add suffix for uname -r
Message-ID: <20010506180803.A1179@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105060334390.1549-100000@asdf.capslock.lan> <3437.989135106@ocs3.ocs-net> <20010506101217.H3988@marowsky-bree.de> <20010506013605.C31385@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010506013605.C31385@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Sun, May 06, 2001 at 01:36:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 01:36:05AM -0700, Mike Castle wrote:
> On Sun, May 06, 2001 at 10:12:17AM +0200, Lars Marowsky-Bree wrote:
> > You assign a new EXTRAVERSION to the new kernel you are building, and keep the
> > old kernel at the old name.
> 
> Except that some patches (ie, RAID, -ac) use EXTRAVERSION.  There needs to
> be a new variable, say USERVERSION, that will *ONLY* be set during make
> USERVERSION=foo.

Ok, so we have $(VERSION).$(MINOR).$(PATCHLEVEL)$(EXTRAVERSION)$(USERVERSION).
Isn't this the same as $(VERSION).$(MINOR).$(PATCHLEVEL)$(EXTRAVERSION) where
$(EXTRAVERSION) has $(USERVERSION) appended?

In other words:

EXTRAVERSION=-ac4-build1

You can extend EXTRAVERSION infinitely, but after the first 10 or so
characters, it starts to get silly.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

