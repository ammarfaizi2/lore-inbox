Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVDKPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVDKPXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVDKPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:23:48 -0400
Received: from smtp.artisan.se ([194.52.183.30]:52619 "EHLO smtp.artisan.se")
	by vger.kernel.org with ESMTP id S261803AbVDKPXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:23:37 -0400
From: =?iso-8859-1?q?Bj=F6rn_Elwhagen?= <bjorn.elwhagen@home.se>
To: linux-kernel@vger.kernel.org
Subject: Crash on firewall using 2.6.11.6
Date: Mon, 11 Apr 2005 17:23:12 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111723.12570.bjorn.elwhagen@home.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've encountered the strangest problem yet in my linux career...I'll just 
explain my setup, what happens, and what solved the problem and you can decide 
if you are more interested after that...

* Company firewall 2.6.8.1 ip-address 1.2.3.4 with priv net 192.168.1
* Home firewall 2.6.11.6 ip-address 4.3.2.1 with priv net 192.168.2
* OpenSWAN with IPSEC connecting the two private networks, not traffic between 
the firwall hosts themselves as far as i know
* Other external address 1.2.3.5 DNAT'ed to 192.168.1.100

Connected from WinXP machine on home net using putty to 1.2.3.5 address on 
company firewall, so the traffic should not be encrypted via IPSEC.

(Next step, just don't try to figure out why i did it, was just curious what 
would show). Using `strings` command on on a .tgz file on the putty-terminal 
connected to 1.2.3.5  i got my home firewall to crash.

First i thought it was a random crash, but i tried a couple of times more just 
to make sure, and it crashed then as well.

I upgraded my home firewall to 2.6.11.7 and tried to duplicate the crash, but 
it didn't crash then so i guess the problem somehow was solved.

Do you have any idea what caused the crash, i didn't see anything obvious for 
me in the changelog for 2.6.11.7.

Just tell me if you would like more info of any kind, firwall rules, traffic 
dump etc?

Best regards,

Bjorn
