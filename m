Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131611AbRBQCJp>; Fri, 16 Feb 2001 21:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbRBQCJf>; Fri, 16 Feb 2001 21:09:35 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:29708 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S131373AbRBQCJa>; Fri, 16 Feb 2001 21:09:30 -0500
Date: Fri, 16 Feb 2001 18:09:26 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: <jbwan@home.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: too long mac address for --mac-source netfilter option
In-Reply-To: <20010217014042.CDAY585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Message-ID: <Pine.LNX.4.32.0102161803580.18153-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Jack & All ,  Might this be an atm interface ?
	If it is not then am I to assume that an atm interface
	with its erroneous mac-address is going to have the same
	difficulties .  That is of course as soon as the atm interface
	actually put a valid ESI/mac-address into the interface table .
		Tia ,  JimL

On Fri, 16 Feb 2001, Jack Bowling wrote:
>> I am trying to use the --mac-source option in the netfilter code to
>better refine access to my linux box. However, I have run up against
>something. The router through which my private subnet work box passes
>sends a 14-group "invalid" mac address, presumably as an attempt to
>conceal the real hextile mac address. However, the code for the
>--mac-source netfilter option is looking for a valid hextile mac address
>and complains loudly as such (numerals converted to x's):
> iptables v1.1.1: Bad mac address `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx'
> to the respective iptable line:
>> $IPT -A INPUT -p tcp -s xxx.xxx.xxx.xxx -d $NET -m mac --mac-source
>xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx --dport 5900:5901 -j ACCEPT
>> The idea here is to allow VNC access to my home box with the access
>filtered by both IP and mac address.
>> Is there a resolution to this other than a rewrite and recompile of the
>relevant sections of the iptable code? Or am I stuck? I know this option
>is tagged by Rusty as experimental still so I would assume that the code
>is open for feedback ;) The question could be rephrased as: is there any
>chance of allowing "invalid" mac addresses to be recognized by the
>--mac-source option of the netfilter code? Running Redhat v7/kernel
>2.4.1-ac15.

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

