Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136001AbRA1CQ4>; Sat, 27 Jan 2001 21:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136474AbRA1CQr>; Sat, 27 Jan 2001 21:16:47 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:51381 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S136001AbRA1CQm>;
	Sat, 27 Jan 2001 21:16:42 -0500
Date: Sat, 27 Jan 2001 21:15:48 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Chris Wedgwood <cw@f00f.org>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: ECN: Clearing the air
In-Reply-To: <20010128150813.A1595@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.30.0101272110470.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Chris Wedgwood wrote:

> On Sat, Jan 27, 2001 at 07:23:51PM -0500, jamal wrote:
>
>     suggested blocking ECN. Article at:
>
>     http://www.securityfocus.com/frames/?focus=ids&content=/focus/ids/articles/portscan.html
>
> the site is now ATM -- can someone briefly explain the logic in
> blocking it?
>

It is Queso they quoted not nmap, sorry -- same thing.
The idea is to "detect" port scanners.
Queso sets the two TCP reserved bits in the SYN (now allocated for ECN).
Some OSes reflect that back in the SYN-ACK (Linux < 2.0.2? for example
was such a culprit).
Queso could then use that information to narow down the OS detection.
I suppose the idea is to detect Queso and react to it ;->

cheers,
jamal



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
