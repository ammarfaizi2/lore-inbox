Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269063AbTBXBph>; Sun, 23 Feb 2003 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269065AbTBXBph>; Sun, 23 Feb 2003 20:45:37 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:54924 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S269063AbTBXBpg>; Sun, 23 Feb 2003 20:45:36 -0500
Message-Id: <200302240155.h1O1tPGi027912@locutus.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: Mitchell Blank Jr <mitch@sfgoth.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm? 
In-reply-to: Your message of "Sun, 23 Feb 2003 00:15:50 -0300."
             <20030223001550.I2791@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sun, 23 Feb 2003 20:55:25 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030223001550.I2791@almesberger.net>,Werner Almesberger writes:
>The "cb must be in virgin state" rule is indeed news to me. But
>maybe the rule has always been there, and nobody really noticed :-)

its particularly a problem (on the ia64 anyway) in ip_options_echo().
optlen (in skb_inet_parm) winds up with values >>40 and it overwrites 
the stack.  it looks like the ip stack wants to process the options
block once and tuck it away in skb_inet_parm.
