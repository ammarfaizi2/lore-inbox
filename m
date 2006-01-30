Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWA3KSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWA3KSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWA3KSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:18:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15242 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750993AbWA3KSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:18:07 -0500
Date: Mon, 30 Jan 2006 11:18:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: config order problems
Message-ID: <Pine.LNX.4.61.0601301114440.25336@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


there is a slight problem with `make config` (oldconfig, silentoldconfig).
By the time we get to the

  Netfilter Xtables support (required for ip_tables) 
  (NETFILTER_XTABLES) [N/m/y/?] (NEW) m

part, CONFIG_NETFILTER_XT_TARGET_CONNMARK is for example not offered 
because it depends on IP_NF_MANGLE which can be selected later. It is 
therefore impossible to select CONNMARK without having to go through config 
twice. In case of automated scripts, this means that CONNMARK remains 
unselected unless special actions were taken.



Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
