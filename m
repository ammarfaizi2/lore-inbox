Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUHVPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUHVPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHVPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:06:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:41432 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267382AbUHVPGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:06:07 -0400
Date: Sun, 22 Aug 2004 17:04:14 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: root@chaos.analogic.com, adilger@clusterfs.com, jlcooke@certainkey.com,
       shemminger@osdl.org, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040822170414.3ecab1e5.ak@suse.de>
In-Reply-To: <20040820124823.071ac1d9.davem@redhat.com>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040820175952.GI5806@certainkey.com>
	<20040820185956.GV8967@schnapps.adilger.int>
	<Pine.LNX.4.53.0408201518250.25319@chaos>
	<20040820124823.071ac1d9.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 12:48:23 -0700
"David S. Miller" <davem@redhat.com> wrote:

> > I wouldn't suggest converting it to 'C' because the rotation
> > takes many CPU instructions when one tries to do the test, shift,
> > and OR in 'C',
> 
> You only need 2 'shifts' and an 'or' to do a rotate in C.
> No tests are needed.

gcc is clever enough to detect the common C patterns for rotate
and generate a real ROL when the CPU supports it.

-Andi
