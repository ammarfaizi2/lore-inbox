Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbUCPK5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCPK5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:57:00 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:15822 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263450AbUCPK4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:56:51 -0500
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 16 Mar 2004 11:56:37 +0100
Message-ID: <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> (davej@redhat.com's
 message of "Mon, 15 Mar 2004 21:47:00 GMT")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "davej" == davej  <davej@redhat.com> writes:

davej>  #ifdef CONFIG_EISA
davej> -	if (eisa_driver_register (&el3_eisa_driver) < 0) {
davej> +	if (eisa_driver_register (&el3_eisa_driver) <= 0) {
davej>  		eisa_driver_unregister (&el3_eisa_driver);
davej>  	}
davej>  #endif

This is bogus. eisa_driver_register returns 0 when it *succeeds*.

	M.
-- 
Places change, faces change. Life is so very strange.
