Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUBUPue (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 10:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbUBUPue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 10:50:34 -0500
Received: from gate.firmix.at ([80.109.18.208]:34536 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261578AbUBUPud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 10:50:33 -0500
Subject: Re: 2.6.3-ck1
From: Bernd Petrovitsch <bernd@firmix.at>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402182336.31420.kernel@kolivas.org>
References: <200402182336.31420.kernel@kolivas.org>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1077378620.9311.1.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 16:50:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 13:36, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
[...]
> http://kernel.kolivas.org
> 
> Description:
> am6
> Autoregulates the virtual memory swappiness.

This actually has a problem if swapping is disabled via the .config
file. The patch uses 'swapper_space.nrpages' which does not exist (in
the no-swap-space situation). Instead 'total_swapcache_pages' apparently
should be used.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


