Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267865AbTBRQye>; Tue, 18 Feb 2003 11:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267866AbTBRQye>; Tue, 18 Feb 2003 11:54:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11443 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267865AbTBRQyd>;
	Tue, 18 Feb 2003 11:54:33 -0500
Date: Tue, 18 Feb 2003 09:01:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Paul Rolland" <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recovering .config from vmlinuz and System.map
Message-Id: <20030218090103.01365887.rddunlap@osdl.org>
In-Reply-To: <012a01c2d75a$1d7b8d20$3f00a8c0@witbe>
References: <012a01c2d75a$1d7b8d20$3f00a8c0@witbe>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003 15:29:16 +0100
"Paul Rolland" <rol@as2917.net> wrote:

| I've a box running a linux 2.4.18-14 (RH stuff), for which I've lost
| the .config file...
| 
| I've gone through a long .config recovery process by looking at the
| entries in System.map, changing the configuration, building the kernel,
| diffing the new System.map with the reference one, again and again.
| 
| The diff process was done only on the symbol names and the last diff
| states :
| diff -urN System.map-9 System.map-2.4.18-sound | less
| --- System.map-9        Tue Feb 18 13:36:33 2003
| +++ System.map-2.4.18-sound     Tue Feb 18 09:47:47 2003
| @@ -10776,6 +10776,7 @@
|  d __setup_str_console_setup
|  d __setup_str_reserve_setup
|  d startup.0
| +d configs
|  d zone_balance_ratio
|  d zone_balance_min
|  d zone_balance_max
| 
| Could someone direct me to where is located this "configs" stuff
| that I can't find ?

I wrote an optional feature that stores kernel .config info inside
the 'vmlinux' file in an array named 'configs'.  I don't know if
it's included in your kernel or not.

Some patches for this in-kernel-config feature are available at
http://www.osdl.org/archive/rddunlap/patches/ikconfig/
and it's in Alan Cox's 2.4.-recent patches.

--
~Randy
