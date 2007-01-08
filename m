Return-Path: <linux-kernel-owner+w=401wt.eu-S1422732AbXAHUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbXAHUpW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbXAHUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:45:22 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2652 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932661AbXAHUpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:45:21 -0500
Date: Mon, 8 Jan 2007 21:45:20 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] update MMConfig patches w/915 support
Message-ID: <20070108204520.GB15481@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>
References: <200701071142.09428.jbarnes@virtuousgeek.org> <200701071144.16045.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701071144.16045.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:44:16AM -0800, Jesse Barnes wrote:
> For reference, here's the probe routine I tried for 965, probably something 
> dumb wrong with it that I'm not seeing atm.

It shouldn't have mattered in your case, but base_address is limited
to 32bits.  There is a 32 bits reserved zone after it so hope is not
to be lost, but in any case the current code can't handle over-4G base
addresses at that point.

Does the bios or your '965 give a correct acpi mmconfig entry?

  OG.

> P.S.  Hooray for Intel for publishing their bridge specs!  Makes stuff like 
> this a bit easier.

Ohhh yes.
