Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRBZXsV>; Mon, 26 Feb 2001 18:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRBZXsK>; Mon, 26 Feb 2001 18:48:10 -0500
Received: from boreas.isi.edu ([128.9.160.161]:19087 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S129250AbRBZXrx>;
	Mon, 26 Feb 2001 18:47:53 -0500
To: linux-kernel@vger.kernel.org
From: Craig Milo Rogers <Rogers@ISI.EDU>
Subject: 2.2.19pre15: drivers/net/Config.in: 359: bad if condition
Date: Mon, 26 Feb 2001 15:47:51 -0800
Message-ID: <28703.983231271@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After building a patched source tree, and running "make xmenu" on a
RH6.2 system with most relevant RPMs installed, I see:

drivers/net/Config.in: 359: bad if condition

The following line:
if [ "$CONFIG_EXPERIMENTAL" = y -a "$CONFIG_WAN_ROUTER" != "n" ]; then

should be:
if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_WAN_ROUTER" != "n" ]; then


					Craig Milo Rogers
