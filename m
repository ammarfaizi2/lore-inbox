Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUCPNsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCPNsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:48:50 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:6533 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261674AbUCPNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:48:47 -0500
Date: Tue, 16 Mar 2004 13:46:13 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Message-ID: <20040316134613.GA15600@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 11:56:37AM +0100, Marc Zyngier wrote:
 > >>>>> "davej" == davej  <davej@redhat.com> writes:
 > 
 > davej>  #ifdef CONFIG_EISA
 > davej> -	if (eisa_driver_register (&el3_eisa_driver) < 0) {
 > davej> +	if (eisa_driver_register (&el3_eisa_driver) <= 0) {
 > davej>  		eisa_driver_unregister (&el3_eisa_driver);
 > davej>  	}
 > davej>  #endif
 > 
 > This is bogus. eisa_driver_register returns 0 when it *succeeds*.

Then the probing routine is bogus, it returns 0 when it fails too.

		Dave

