Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264848AbTIDU1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbTIDU1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:27:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:54802 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264848AbTIDU1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:27:38 -0400
Date: Thu, 4 Sep 2003 22:27:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org,
       kai.germaschewski@gmx.de, cherry@osdl.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: make checkconfig problem
Message-ID: <20030904202737.GA10691@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org,
	kai.germaschewski@gmx.de, cherry@osdl.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20030904123452.62dd732e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904123452.62dd732e.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 12:34:52PM -0700, Randy.Dunlap wrote:
> 
> You probably already know this...
> 
> Someone mentioned to me that 'make checkconfig' isn't working.
> However, 'make checkincludes' does work.

It had crossed my mind, and my plan was actually to get rid of them
since the scripts were not updated. Good to see you are looking into
this now.

If we want to keep them in the kernel, I suggest a new naming:
configcheck:
includecheck:

This follows the *config pattern, but suffixed with check.

A tangent - could it be possible to build this into sparse instead?
The plan is to give it more kernel awareness anyway, so it should
be simple to check for the above as well.

	Sam
