Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVILBjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVILBjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 21:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVILBjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 21:39:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:8890 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751124AbVILBjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 21:39:52 -0400
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	<20050911185711.GA22556@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	<20050911194630.GB22951@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
	<52irx7cnw5.fsf@cisco.com>
	<Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
	<Pine.LNX.4.58.0509111431400.3242@g5.osdl.org>
Date: Sun, 11 Sep 2005 18:39:45 -0700
In-Reply-To: <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Sep 2005 14:33:19 -0700 (PDT)")
Message-ID: <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, there's no reason why a client-side thing couldn't just parse the 
> "alternates" thing, and if it doesn't find the objects in the main object 
> directory, go and fetch them from the alternates itself.

There is.

For kernel.org, you could say '/pub/scm/blah' in your alternates
and expect it to work, only because http://kernel.org/pub
hierarchy happens to match the absolute path /pub on the
filesystem, but for most people's default HTTP server
installation, they would need to say /var/www/scm/blah to have
alternate work locally, but somebody has to know that the named
directory is served as http://machine.xz/pub/scm/blah somewhere.

Client side smarts need some help from the user here to know
that '/var/www/scm/blah' read off of objects/info/alternates
match that URL.

