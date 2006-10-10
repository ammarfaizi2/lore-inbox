Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWJJWrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWJJWrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbWJJWrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:47:31 -0400
Received: from rune.pobox.com ([208.210.124.79]:62404 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1030586AbWJJWra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:47:30 -0400
Date: Tue, 10 Oct 2006 15:47:17 -0700
From: Paul Dickson <paul@permanentmail.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/2] round_jiffies users
Message-Id: <20061010154717.e2c4c149.paul@permanentmail.com>
In-Reply-To: <1160496263.3000.312.camel@laptopd505.fenrus.org>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	<1160496210.3000.310.camel@laptopd505.fenrus.org>
	<1160496263.3000.312.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 18:04:23 +0200, Arjan van de Ven wrote:

> +			mod_timer(&adapter->phy_info_timer, round_jiffies(jiffies + 2 * HZ));

Shouldn't round_jiffies_relative be used for some of these, a la:

  +			mod_timer(&adapter->phy_info_timer, round_jiffies_relative(2 * HZ));

	-Paul

