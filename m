Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279752AbRJ3Cc5>; Mon, 29 Oct 2001 21:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279754AbRJ3Ccr>; Mon, 29 Oct 2001 21:32:47 -0500
Received: from anime.net ([63.172.78.150]:51212 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S279752AbRJ3Ccg>;
	Mon, 29 Oct 2001 21:32:36 -0500
Date: Mon, 29 Oct 2001 18:33:04 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: willy tarreau <wtarreau@yahoo.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <3BDDDF6A.B823F5C3@nortelnetworks.com>
Message-ID: <Pine.LNX.4.30.0110291831160.9540-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Christopher Friesen wrote:
> Are there issues with using MII to detect link state?  I thought it was fairly
> reliable...

It doesn't work to detect link state through bridging device (say, bridged
ethernet over T3). The T3 might go down, but your MII link to the local
router will remain "up", so you will never know about the loss of link and
your packets will happily go into the void...

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

