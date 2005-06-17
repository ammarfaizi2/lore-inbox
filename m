Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVFQFgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVFQFgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 01:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFQFgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 01:36:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38060 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261885AbVFQFgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 01:36:35 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.11-rc5: mysterious loss of tx
Date: Fri, 17 Jun 2005 08:36:17 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506170836.17855.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

My home box has onboard via-rhine NIC.

Several days ago my father called me and said that
it does not send anything (tcpdump shows only rx'ed pkts
despite pings being attempted etc). I did not investigate
then.

Yesterday I've seen it myself. I bumped up ethtool msglvl.
Looks like via-rhine's hard_start_xmit was not called at all
from network core code! (I did not see debug printks from
rhine's hard_stat_xmit routine)

Whatever I tried (ifconfig down/up, reinit IP config from scratch),
nothing helped. No tx whatsoever was attempted by kernel, it seems.

Reboot 'fixed' things.

It hever happened on the same hardware before I switched to rc5.
--
vda

