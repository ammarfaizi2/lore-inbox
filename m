Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVDCTxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDCTxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDCTxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:53:45 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:15033 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261328AbVDCTxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:53:44 -0400
Subject: Re: [PATCH 4/4] psmouse: dynamic protocol switching via sysfs
From: Kenan Esau <kenan.esau@conan.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200503220217.47624.dtor_core@ameritech.net>
References: <20050217194217.GA2458@ucw.cz>
	 <200503220215.34198.dtor_core@ameritech.net>
	 <200503220216.38756.dtor_core@ameritech.net>
	 <200503220217.47624.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 21:49:25 +0200
Message-Id: <1112557765.3625.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-3 are fine.

Protocol switching via sysfs works too but if I switch from LBPS/2 to
PS/2 the device name changes from "/dev/event1" to "/dev/event2" -- is
this intended?

If I do "echo -n 50 > resolution" "0xe8 0x01" is sent. I don't know if
this is correct for "usual" PS/2-devices but for the lifebook it's
wrong.

For the lifebook the parameters are as following:

50cpi  <=> 0x00
100cpi <=> 0x01
200cpi <=> 0x02
400cpi <=> 0x03

