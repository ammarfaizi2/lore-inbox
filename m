Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131473AbRBQBlL>; Fri, 16 Feb 2001 20:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRBQBlB>; Fri, 16 Feb 2001 20:41:01 -0500
Received: from mail2.rdc2.bc.home.com ([24.2.10.85]:24977 "EHLO
	mail2.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S131473AbRBQBkt>; Fri, 16 Feb 2001 20:40:49 -0500
Date: Fri, 16 Feb 2001 17:40:04 -0800
From: Jack Bowling <jbinpg@home.com>
To: linux-kernel@vger.kernel.org
Subject: too long mac address for --mac-source netfilter option
Reply-To: jbwan@home.com
X-Mailer: Spruce 0.7.5 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010217014042.CDAY585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to use the --mac-source option in the netfilter code to better refine access to my linux box. However, I have run up against something. The router through which my private subnet work box passes sends a 14-group "invalid" mac address, presumably as an attempt to conceal the real hextile mac address. However, the code for the --mac-source netfilter option is looking for a valid hextile mac address and complains loudly as such (numerals converted to x's): 

iptables v1.1.1: Bad mac address `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx'

to the respective iptable line:

$IPT -A INPUT -p tcp -s xxx.xxx.xxx.xxx -d $NET -m mac --mac-source xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx --dport 5900:5901 -j ACCEPT 

The idea here is to allow VNC access to my home box with the access filtered by both IP and mac address.

Is there a resolution to this other than a rewrite and recompile of the relevant sections of the iptable code? Or am I stuck? I know this option is tagged by Rusty as experimental still so I would assume that the code is open for feedback ;) The question could be rephrased as: is there any chance of allowing "invalid" mac addresses to be recognized by the --mac-source option of the netfilter code? Running Redhat v7/kernel 2.4.1-ac15.

Jack Bowling
mailto: jbinpg@home.com






