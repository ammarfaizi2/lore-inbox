Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWJEB5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWJEB5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJEB5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:57:50 -0400
Received: from mail2.genealogia.fi ([194.100.116.229]:32978 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751321AbWJEB5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:57:49 -0400
Date: Wed, 4 Oct 2006 18:55:26 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Theodore Tso <tytso@mit.edu>
Cc: Jean Tourrilhes <jt@hpl.hp.com>, Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: LEAP (was: wpa supplicant/ipw3945, ESSID last char missing)
Message-ID: <20061005015526.GB6145@jm.kir.nu>
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <20061004232939.GA19647@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004232939.GA19647@thunk.org>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 07:29:39PM -0400, Theodore Tso wrote:

> P.S.  Because of all of these changing interfaces, I *still* haven't
> been able to get wpa_supplicant working with LEAP so I can get
> wireless access to in IBM offices using my ipw3945 driver.  I've
> tried, and failed.  Sigh, I guess I'm not smart enough....

This is getting somewhat off topic to the main thread, but anyway, LEAP
is quite an odd beast as far as EAP methods are concerned and the way it
is implemented in Cisco APs makes it even worse.. LEAP can mean so many
different things that it is difficult to give any generic answer to how
to do this. Just about any other wireless security configuration would
be easier to explain.. ;-)

Feel free to write me more details on the configuration used in the
network and I can try to figure out how that would need to be
configured. I would need to know whether LEAP is being used with IEEE
802.1X (dynamic WEP keys; key_mgmt=IEEE8021X in wpa_supplicant)) or with
WPA (key_mgmt=WPA-EAP in wpa_supplicant). In addition, it would be
useful to know whether the APs are configured to require Cisco
prorietary "Network EAP" authentication algorithm (auth_alg=LEAP in
wpa_supplicant) or not. Many of the drivers do not support that at all..
I don't know whether ipw3945 does since I have not tested this myself
and do not remember having heard of a clear report on this being used.

And just hope that the APs do not require Cisco proprietary CKIP or CMIC
encryption algorithms which are most likely not supported by ipw3945 (or
most Linux drivers for that matter)..

-- 
Jouni Malinen                                            PGP id EFC895FA
