Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTIWGdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 02:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTIWGdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 02:33:49 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:60934 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261905AbTIWGds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 02:33:48 -0400
To: Christoph Hellwig <hch@misterjones.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill CONFIG_EISA_ALWAYS
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20030922194005.GA29357@lst.de>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 23 Sep 2003 08:31:04 +0200
Message-ID: <wrpr828qamv.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030922194005.GA29357@lst.de> (Christoph Hellwig's message of
 "Mon, 22 Sep 2003 21:40:05 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "HCH" == Christoph Hellwig <hch@lst.de> writes:

HCH> I'd like to kill willy's CONFIG_EISA_ALWAYS kludge.  So make
HCH> EISA_bus a variable always when CONFIG_EISA is set and initialize
HCH> it to 1 for alpha.  We probably want to do that only if the system
HCH> actually supports eisa, but I keep the old behaviour for now.

HCH> Also remove the CONFIG_EISA helptext on alpha as it's not user-visible.

I do not mind the change, but you might want to check that with
Richard Henderson. Maybe there was a good reason for EISA_bus to be
#defined on Alpha (although I really can't see it at the moment...).

Having a single way to define EISA_bus will help its removal in the
future...

	M.
-- 
Places change, faces change. Life is so very strange.
