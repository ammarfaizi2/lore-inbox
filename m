Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbREZD0C>; Fri, 25 May 2001 23:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbREZDZw>; Fri, 25 May 2001 23:25:52 -0400
Received: from pop.gmx.net ([194.221.183.20]:9232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262586AbREZDZp>;
	Fri, 25 May 2001 23:25:45 -0400
Message-ID: <3B0F1DF9.238C01B9@gmx.de>
Date: Sat, 26 May 2001 05:07:37 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105241925230N.06233@starship> <3B0D763C.26991788@gmx.de> <0105251300000V.06233@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Oops, oh wait, there's already another open point: your breakage
> examples both rely on opening ".".  You're right, "." should always be
> a directory and I believe that's enforced by the VFS.  So we don't have
> an example of breakage yet.

That's just because I did a simple "ls".  But it doesn't make a
difference.  The magicdevs _are_ directories and

	chdir("magicdev");
	open(".", O_RDONLY);

shouldn't open the device.

Ciao, ET.

