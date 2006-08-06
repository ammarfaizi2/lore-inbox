Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWHFUKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWHFUKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWHFUKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:10:39 -0400
Received: from ozlabs.org ([203.10.76.45]:49862 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750703AbWHFUKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:10:38 -0400
Date: Mon, 7 Aug 2006 06:08:09 +1000
From: Anton Blanchard <anton@samba.org>
To: David Miller <davem@davemloft.net>
Cc: molle.bestefich@gmail.com, auke-jan.h.kok@intel.com,
       charlieb@budge.apana.org.au, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: e100: checksum mismatch on 82551ER rev10
Message-ID: <20060806200809.GC4209@krispykreme>
References: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com> <44D0D7CA.2060001@intel.com> <62b0912f0608040404p59545a0asc7f5fc5f537ec32c@mail.gmail.com> <20060804.042024.63108922.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804.042024.63108922.davem@davemloft.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> If the EEPROM has a broken checksum, the user should have an option
> that allows him to try and use the device anyways, end of story.

Ive come across this problem a number of times on e1000 chips (to be
clear it was vendor programming issues).

The driver has the option to read and write the EEPROM already. All we
need is the ability for the driver to hang around so that we can use
ethtool to fix it.

At the moment we carry an out of tree patch to do this.

Anton
