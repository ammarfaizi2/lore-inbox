Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291645AbSBTFIC>; Wed, 20 Feb 2002 00:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291649AbSBTFHx>; Wed, 20 Feb 2002 00:07:53 -0500
Received: from arsenal.visi.net ([206.246.194.60]:26778 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S291645AbSBTFHs>;
	Wed, 20 Feb 2002 00:07:48 -0500
Date: Wed, 20 Feb 2002 00:05:27 -0500
From: Ben Collins <bcollins@debian.org>
To: Sandeep Gopal Nijsure <nijsure@cs.unt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About net part of the kernel
Message-ID: <20020220050527.GR3914@blimpo.internal.net>
In-Reply-To: <Pine.LNX.3.96.1020219225420.6940B-100000@csp05.csci.unt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020219225420.6940B-100000@csp05.csci.unt.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 10:58:53PM -0600, Sandeep Gopal Nijsure wrote:
> Hi,
> 
> I want to make, say, a machine 10.0.0.5 accept an IP packet with the
> destination address of 10.0.0.2. I hope I can do this by changing a bit of
> kernel networking code, where it's decided whether to accept an IP packet
> as a local packet.. I could not locate the code.. could anybody tell me
> where exactly the decision process take place?

You could just use device aliasing:

ifconfig eth0 10.0.0.5
ifconfig eth0:1 10.0.0.2

Either that, or if you simply want to sniff network packets, look into
turning on promiscuous mode (as tcpdump does).

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/       Ben Collins    --    Debian GNU/Linux    --    WatchGuard.com      \
`          bcollins@debian.org   --   Ben.Collins@watchguard.com           '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
