Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWC0RNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWC0RNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWC0RNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:13:22 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56272 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750720AbWC0RNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:13:21 -0500
Subject: Re: [PATCH] pcmcia: avoid binding hostap_cs to Orinoco cards
From: Pavel Roskin <proski@gnu.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Sebastian <sebastian@expires0606.datenknoten.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@dominikbrodowski.net, Netdev List <netdev@vger.kernel.org>
In-Reply-To: <20060327164844.GF14403@tuxdriver.com>
References: <200603012259.k21MxEN3013604@hera.kernel.org>
	 <44063023.9010603@pobox.com>
	 <1143459885.9691.6.camel@coruscant.datenknoten.de>
	 <20060327164844.GF14403@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 12:12:52 -0500
Message-Id: <1143479572.21729.9.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 11:48 -0500, John W. Linville wrote:
> > this patch seems to break my setup. The hostap_cs driver included in
> > kernel 2.6.16 does not detect my Prism 2 WLAN card anymore, although it
> > is *not* Orinoco. With 2.6.15.5 it still worked.

It mean hostap_cs was identifying the card solely by its numeric ID
(0x0156, 0x0002) instead of the vendor strings.  Since that particular
numeric ID was used both by cards that are supported by hostap_cs and
those that are not, it cannot be used in hostap_cs.

Sebastian, please send me the output of "pccardctl ident" and I'll
submit the patch for hostap_cs.

> This patch didn't come through me, so I don't know much about it.
> Hopefully Pavel or Dominik can comment?

-- 
Regards,
Pavel Roskin

