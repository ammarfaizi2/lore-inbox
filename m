Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132877AbRDQVnr>; Tue, 17 Apr 2001 17:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132881AbRDQVni>; Tue, 17 Apr 2001 17:43:38 -0400
Received: from 13dyn45.delft.casema.net ([212.64.76.45]:9733 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132877AbRDQVnd>; Tue, 17 Apr 2001 17:43:33 -0400
Message-Id: <200104172143.XAA31675@cave.bitwizard.nl>
Subject: Re: ARP responses broken!
In-Reply-To: <E14pXyi-0002d5-00@the-village.bc.nu> from Alan Cox at "Apr 17,
 2001 05:05:16 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 17 Apr 2001 23:43:06 +0200 (MEST)
CC: Martin Josefsson <gandalf@wlug.westbo.se>, Andi Kleen <ak@suse.de>,
        Eric Weigle <ehw@lanl.gov>, Sampsa Ranta <sampsa@netsonic.fi>,
        linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
        zebra@zebra.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > I was asking because I had this problem before (router with two cards
> > against one physical subnet) and arpwatch complained that the router kept
> > switching MACaddresses all the time.
 
> That sounds like a bug in arpwatch. A box can have multiple mac
> addresses. Its probably a tricky one to handle but arpwatch I guess
> should spot and cope with repeated transitions between the same set
> of addresses as one warning

Well, two. Or three. 

- Hey, IP x changed from mac X to mac Y. 
- Hey, IP x changed back again to X. 
- Hmm. IP X seems to be using both Mac X and and Mac Y. 
	No further warnings will be issued about this. 

If someone is taking over an IP address (which is especially what
arpwatch should be looking for), this is exactly what you'll see. Having
the issue be ignored after one warning is bad. 

Oh, and I know people who swear that this would be an invalid
configuration, so that it is good for arpwatch to should loud and
clear about it...

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
