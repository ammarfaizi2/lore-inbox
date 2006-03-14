Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWCNNuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWCNNuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCNNuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:50:13 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:21438 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751089AbWCNNuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:50:12 -0500
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <20060314111248.GA75477@dspnet.fr.eu.org>
References: <20060314111248.GA75477@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 14:49:03 +0100
Message-Id: <1142344144.4448.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

> Broadcom USB Bluetooth adapters report a maximum of zero SCO packets
> in-flight, killing SCO.  Use a reasonable count instead in that case.
> 
> Signed-off-by: Olivier Galibert <galibert@pobox.com>
> 
> ---
> 
> I don't think that could be reasonably done as a quirk.  Simple
> examination of the .inf coming with the windows driver shows that 100+
> different models may be having this problem.  Also, it can't break
> already working adapters, so why bother.

your patch might break devices where this value is chosen on purpose, so
it is not acceptable and must be done with a quirk. Another reason is
that I don't allow any stupid vendor specific workarounds inside the
Bluetooth core unless they are implemented as quirks. The core has no
vendor information at all.

Regards

Marcel


