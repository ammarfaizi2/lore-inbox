Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUIXWJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUIXWJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIXWJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:09:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39913 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268955AbUIXWJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:09:47 -0400
Subject: Re: mlock(1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040924132247.W1973@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com>
	 <20040924132247.W1973@build.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096060045.10800.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 22:07:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 21:22, Chris Wright wrote:
> Hard to say if it's a policy decision outside the scope of the app.
> Esp. if the app knows it needs to not be swapped.  Either something that
> has realtime needs, or more specifically, privacy needs.  Don't need to
> mlock all of gpg to ensure key data never hits swap.

Keys are a different case anyway. We can swap them if we have encrypted
swap (hardware or software) and we could use the crypto lib just to
crypt some pages in swap although that might be complex. As such a
MAP_CRYPT seems better than mlock. If we don't have cryptable swap then
fine its mlock.

