Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135599AbRAGEHI>; Sat, 6 Jan 2001 23:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAGEG7>; Sat, 6 Jan 2001 23:06:59 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28169 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135599AbRAGEGw>;
	Sat, 6 Jan 2001 23:06:52 -0500
Date: Sun, 7 Jan 2001 05:06:49 +0100
From: Andi Kleen <ak@suse.de>
To: jamal <hadi@cyberus.ca>
Cc: Andi Kleen <ak@suse.de>, Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010107050649.A14637@gruyere.muc.suse.de>
In-Reply-To: <20010107042959.A14330@gruyere.muc.suse.de> <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sat, Jan 06, 2001 at 11:00:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 11:00:10PM -0500, jamal wrote:
> Not to stray from the subject, Ben's effort is still needed. I think real
> numbers are useful instead of claims like it "displayed faster"

The problem with old ifconfig was really visible, old ifconfig needed several
minutes to setup. It was slow enough that "visual benchmarking" worked very well.
With the fixed ifconfig it scrolls without too annoying delays.

The ifconfig could be tuned even more by adding a hash table, but it didn't look
necessary (and frankly nobody wants to invest too much work into it, given
that ip is far superior) 

Note that the alias case is different from thousands of devices -- alias works
via SIOCGIFCONF while devices work via /proc/net/dev. 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
