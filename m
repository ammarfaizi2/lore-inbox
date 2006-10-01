Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWJAKku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWJAKku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWJAKku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:40:50 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:41190 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751039AbWJAKkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:40:49 -0400
Date: Sun, 1 Oct 2006 12:40:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Rasenberger <miraze@web.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 violates sandbox feature on linux distribution
Message-ID: <20061001104046.GA10205@uranus.ravnborg.org>
References: <451ABE0E.2030904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451ABE0E.2030904@web.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 06:08:14PM +0000, Michael Rasenberger wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> when building external kernel module on gentoo linux distribution,
> 2.6.18-mm1 violates gentoo's sandbox feature due to file creation in
> "as-instr" test in scripts/Kbuild.include. (AFAIK due to removal of
> revert-x86_64-mm-detect-cfi.patch)

Can you point to to some description of this sandbox feature.
The error you point out looks pretty generic and should happen
in several places - so I need to understand what problem I shall
fix before trying to fix it.

The point is that we have other places where we create temporary files
so this should not be the only issue.

	Sam
