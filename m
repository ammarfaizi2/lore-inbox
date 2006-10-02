Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWJBJBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWJBJBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJBJBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:01:33 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:54245 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1750710AbWJBJBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:01:32 -0400
Date: Mon, 2 Oct 2006 10:59:42 +0200
To: hostap@shmoo.com, ipw3945-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all!

I have the following problem with wpa supplicant/ipw3945. First the
versions:
kernel:	2.6.18-mm2	(self compiled)
ieee80211:	1.1.14
ipw3945:	git source
ipw3945d:	1.7.19
wpa supplicant:	0.5.5	(Debian/unstable 0.5.5-1)


Config file of wpa_supplicant:
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
eapol_version=1
ap_scan=1
network={
        ssid="norbunet"
        key_mgmt=NONE
        auth_alg=SHARED
        wep_key0=HEXKEY1
        wep_key1=HEXKEY2
        wep_key2=HEXKEY3
        wep_key3=HEXKEY4
        wep_tx_keyidx=0
        priority=5
}

When I start ipw3945d and wpa_supplicant it does not connect. And the
reason is that when typing
	iwconfig eth2
(eth0 cable, eth1 not present!?!, eth2 ipw3945) I see that the ESSID is
set to
	"norbune"
instead of
	"norbunet"

Calling
	iwconfig eth2 essid "norbunet "
(mind the space at the end) immediately connects (even with encryption)
and everything is working.

Do you have any idea what this might be related to?

The last kernel I tried which worked out of the box (well, with
comnpiling ieee and ipw) was 2.6.18-rc4.


Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
`I think you ought to know that I'm feeling very
depressed.'
`Life, don't talk to me about life.'
`Here I am, brain the size of a planet and they ask me to
take you down to the bridge. Call that "job satisfaction"?
'Cos I don't.'
`I've got this terrible pain in all the diodes down my
left side.'
                 --- Guess who.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
