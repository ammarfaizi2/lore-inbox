Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262907AbSJVXiu>; Tue, 22 Oct 2002 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbSJVXiu>; Tue, 22 Oct 2002 19:38:50 -0400
Received: from rth.ninka.net ([216.101.162.244]:51857 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262907AbSJVXit>;
	Tue, 22 Oct 2002 19:38:49 -0400
Subject: Re: [PATCH] New ARPHRD types
From: "David S. Miller" <davem@rth.ninka.net>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021021221936.GA32390@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 16:55:36 -0700
Message-Id: <1035330936.16084.23.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 15:19, Solomon Peachy wrote:
> IEEE 802.11 has a variable "hardware" header length, 24 bytes for most
> frames but 30 bytes for others.  This poses a problem if you want to
> expose a native 802.11 netdev interface to the OS, as  
> netdev->hardhdr_len et.al. aren't variable.
> 
> But wait, isn't there already ARPHRD_IEEE80211? Yes, but unfortunately,

If ARPHRD_IEEE80211 assumes 24 bytes, and like you say it shouldn't,
fix that bug instead.  Don't add new ARP header types just to put
a bandaid on another bug.


