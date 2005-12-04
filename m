Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVLDUli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVLDUli (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLDUli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:41:38 -0500
Received: from hera.kernel.org ([140.211.167.34]:39354 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932336AbVLDUlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:41:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: virtual interface mac adress
Date: Sun, 4 Dec 2005 12:41:22 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dmvk9i$631$1@terminus.zytor.com>
References: <20051204192958.64093.qmail@web60214.mail.yahoo.com> <Pine.LNX.4.63.0512041520320.29211@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1133728883 6242 127.0.0.1 (4 Dec 2005 20:41:23 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 4 Dec 2005 20:41:23 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.63.0512041520320.29211@cuia.boston.redhat.com>
By author:    Rik van Riel <riel@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Sun, 4 Dec 2005, anil dahiya wrote:
> 
> > I want to assign mac addres to virtual adpater and mac
> > address should be like that if it should not create
> > problem in arp resoultion(i.e. mac address should be
> > as real card which able to comunicate  on lan )
> 
> You may be able to get away with using a MAC address
> inside the OUI range that XenSource registered.
> 

Any MAC with bit 0 clear and bit 1 set in the first octet is "local
use"; the best thing to do (unless you have your own OUI) is just to
pick a random address inside this range.  You should only run into
collision problems when you get close to 2^23 hosts on a network.

	-hpa
