Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTKRKjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 05:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTKRKjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 05:39:18 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:20972 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S262446AbTKRKjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 05:39:17 -0500
Date: Tue, 18 Nov 2003 11:39:07 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Keith Whyte <keith@media-solutions.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 fork & defunct child => system is hacked
Message-ID: <20031118103907.GA23644@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Keith Whyte <keith@media-solutions.ie>, linux-kernel@vger.kernel.org
References: <1069053524.3fb87654286b5@ssl.buz.org> <3FB8E40F.EF61CA7@gmx.de> <3FB96718.20103@media-solutions.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB96718.20103@media-solutions.ie>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 06:26:00PM -0600, Keith Whyte wrote:
> 
> { strace listing deleted, see 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106905386725308&w=2 }

First of all, /bin/true doing a fork() basically means you've
been hacked: there should not be any such code in there. The
open("/proc/17904///////////exe" is anouther piece of clear evidence
that your system has been hacked.

Why the additional slashes?

I suspect a library/or LD_PRELOAD hack which simply encodes the getpid()
return value in decimal notation and stores it right into a static
buffer containing

	"/proc//////////////////exe"

because it can't use sprintf at that point for some reason (maybe
just because it is a library/LD_PRELOAD hack).


-- 
Frank
