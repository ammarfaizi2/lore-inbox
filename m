Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUCPOUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUCPOSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:18:33 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:32718 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261852AbUCPOKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:10:00 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk>
	<wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org>
	<20040316134613.GA15600@redhat.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 16 Mar 2004 15:09:49 +0100
Message-ID: <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <20040316134613.GA15600@redhat.com> (Dave Jones's message of
 "Tue, 16 Mar 2004 13:46:13 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave> Then the probing routine is bogus, it returns 0 when it fails too.

Uh ? el3_eisa_probe looks like it properly returns an error...

Or maybe you call a failure not finding a proper device on the bus ?
When the driver registers, the bus may not have been probed yet
(built-in case). So un-registering the driver when it fails to find a
proper device is simply wrong with the current implementation.

In the meantime, 2.6.5-rc1 is broken WRT 3c579.

	M.
-- 
Places change, faces change. Life is so very strange.
