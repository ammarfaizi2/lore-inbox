Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTKMOxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTKMOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:53:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1673
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264308AbTKMOxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:53:35 -0500
Date: Thu, 13 Nov 2003 15:53:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113145301.GJ1649@x30.random>
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com> <3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random> <03Nov13.095622cet.122129@mojo.it.advantest.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03Nov13.095622cet.122129@mojo.it.advantest.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 10:35:22PM +0100, Benoit Poulot-Cazajous wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > the usual problem, and the reason we need a sequence number (increased
> > before and after the repo update). A file lock not.
> 
> Or a file that contains md5sums of the other files in the tree. 
> After the rsync, you recompute the md5sums file, and if it does not match,
> rsync again. As a bonus feature, the md5sums file can be pgp-signed.

agreed, this would work too and it has the advantage of working with the
mirrors too as far as the per-file updates are atomic (should always be
the case). This has the only disavanage of forcing the client and the
server to read all file contents (I normally don't rsync with -c). But
if it simplifies life a lot, it's sure acceptable.
