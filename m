Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130528AbRCDVzv>; Sun, 4 Mar 2001 16:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbRCDVzl>; Sun, 4 Mar 2001 16:55:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29313 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130528AbRCDVzZ>;
	Sun, 4 Mar 2001 16:55:25 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15010.47547.612134.819466@pizda.ninka.net>
Date: Sun, 4 Mar 2001 13:55:07 -0800 (PST)
To: Ulrich Kunitz <gefm21@uumail.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [PATCH] tiny MM performance and typo patches for 2.4.2
In-Reply-To: <20010304224951.B1979@uumail.de>
In-Reply-To: <20010304224951.B1979@uumail.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ulrich Kunitz writes:
 > patch-uk6	In 2.4.x _page_hashfn divides struct address_space pointer
 > 		with a parameter derived from the size of struct
 > 		inode. Deriving this parameter from the size of struct
 > 		address_space makes more sense -- at least for me.

The address_space is %99 of the time (unless swapping, and in that
case the address is constant :-)) inside of an inode struct so this
change actually makes the hash worse.  I looked at this one time
myself...

Later,
David S. Miller
davem@redhat.com
