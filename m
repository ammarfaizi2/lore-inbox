Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbVBEKzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbVBEKzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVBEKzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:55:45 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:48002 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S264245AbVBEKzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:55:22 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][i386] HPET setup, duplicate HPET_T0_CMP needed for some platforms
Date: Sat, 5 Feb 2005 10:55:01 +0000
User-Agent: KMail/1.7.2
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <20050204200238.GA5510@ucw.cz> <20050204154159.A4402@unix-os.sc.intel.com>
In-Reply-To: <20050204154159.A4402@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051055.01438.andrew@walrond.org>
X-Spam-Score: -2.8 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 23:41, Venkatesh Pallipadi wrote:
> + /*
> +  * Some systems seems to need two writes to HPET_T0_CMP,
> +  * to get interrupts working
> +  */

I think you should update this comment in light of the information from 
Vojtech:

/*
 * The first write after writing TN_SETVAL to the config register sets the
 * counter value, the second write sets the threshold.
 */

Andrew Walrond
