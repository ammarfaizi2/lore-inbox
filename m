Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131172AbRBQKvQ>; Sat, 17 Feb 2001 05:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131243AbRBQKvG>; Sat, 17 Feb 2001 05:51:06 -0500
Received: from t5o61p37.telia.com ([195.67.229.37]:25896 "EHLO k-7.stesmi.com")
	by vger.kernel.org with ESMTP id <S131172AbRBQKu6>;
	Sat, 17 Feb 2001 05:50:58 -0500
Message-ID: <3A8E5869.C0ECF08B@hanse.com>
Date: Sat, 17 Feb 2001 11:54:33 +0100
From: Stefan Smietanowski <stefan@hanse.com>
Organization: Hanse Communication
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: jbwan@home.com
CC: linux-kernel@vger.kernel.org
Subject: Re: too long mac address for --mac-source netfilter option
In-Reply-To: <20010217014042.CDAY585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> I am trying to use the --mac-source option in the netfilter code to better refine access to my linux box. However, I > have run up against something. The router through which my private subnet work box passes sends a 14-group "invalid" > mac address, presumably as an attempt to conceal the real hextile mac address. However, the code for the > --mac-source netfilter option is looking for a valid hextile mac address and complains loudly as such (numerals converted to x's):
> 
> iptables v1.1.1: Bad mac address `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx'
> 
> to the respective iptable line:
> 
> $IPT -A INPUT -p tcp -s xxx.xxx.xxx.xxx -d $NET -m mac --mac-source xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx --dport 5900:5901 -j ACCEPT
> 
> The idea here is to allow VNC access to my home box with the access filtered by both IP and mac address.
> 
> Is there a resolution to this other than a rewrite and recompile of the relevant sections of the iptable code? Or am I stuck? I know this option is tagged by Rusty as experimental still so I would assume that the code is open for feedback ;) The question could be rephrased as: is there any chance of allowing "invalid" mac addresses to be recognized by the --mac-source option of the netfilter code? Running Redhat v7/kernel 2.4.1-ac15.

Umm..  An ethernet MAC address is 48bit long, ie AA:BB:CC:DD:EE:FF, 6
groups, not 14. Is this really an ethernet
interface? (If it really has 14 groups).

// Stefan
