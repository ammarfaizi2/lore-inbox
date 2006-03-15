Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWCOPfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWCOPfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWCOPfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:35:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:32229 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751961AbWCOPfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:35:45 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jiri Benc <jbenc@suse.cz>
Cc: Bernd Petrovitsch <bernd@firmix.at>, rusty@rustcorp.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: fix buffer overflow
References: <20060315154436.4286d2ab@griffin.suse.cz>
	<1142434648.17627.5.camel@tara.firmix.at>
	<20060315160858.311e5c0e@griffin.suse.cz>
X-Yow: Remember, in 2039, MOUSSE & PASTA will be available
 ONLY by prescription!!
Date: Wed, 15 Mar 2006 16:35:43 +0100
In-Reply-To: <20060315160858.311e5c0e@griffin.suse.cz> (Jiri Benc's message of
	"Wed, 15 Mar 2006 16:08:58 +0100")
Message-ID: <je4q1zpvow.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Benc <jbenc@suse.cz> writes:

> +		while (buf->size - buf->pos < len + 1)
> +			buf->size += 128;

What's wrong with

                buf->size = buf->pos + len + 1;

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
