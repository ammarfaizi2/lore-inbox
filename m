Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTKMQkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTKMQkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:40:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63378
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264368AbTKMQkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:40:31 -0500
Date: Thu, 13 Nov 2003 17:39:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Andreas Schwab <schwab@suse.de>,
       Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113163958.GM1649@x30.random>
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com> <3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random> <03Nov13.095622cet.122129@mojo.it.advantest.de> <20031113145301.GJ1649@x30.random> <jen0b047ir.fsf@sykes.suse.de> <20031113162945.GB2462@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113162945.GB2462@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 08:29:45AM -0800, Larry McVoy wrote:
> If we had this approach we wouldn't have caught the torjan horse in the
> CVS tree.  We checksum all the data, changed or not.  Your approach
> pushes that duty onto the end users, and let's have a show of hands,

the suggestion of the md5sum wasn't related to keeping the data
secure/robust, we don't want to move the "robustness" duty onto the end
users of course, we only want to know when we can break the rsync loop.
The fact we'll do a further check possibly with a signature on the
md5sums, is a bonus, but it's not meant to replace in any way the
robusteness effort on the server side and we don't do it for robustness,
we do it only for providing a means of coherency to the changesets in
the tree.
