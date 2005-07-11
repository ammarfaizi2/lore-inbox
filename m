Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVGKNw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVGKNw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGKNvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:51:21 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:21666 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261676AbVGKNvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:51:12 -0400
To: Stelian Pop <stelian@popies.net>
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
References: <20050708101731.GM18608@sd291.sivit.org>
	<1120821481.5065.2.camel@localhost>
	<20050708121005.GN18608@sd291.sivit.org>
	<20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com>
	<20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
	<1121078371.12621.36.camel@localhost.localdomain>
	<20050711035244.115067ac.akpm@osdl.org>
	<20050711110416.GA24652@sd291.sivit.org>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jul 2005 15:25:07 +0200
In-Reply-To: <20050711110416.GA24652@sd291.sivit.org>
Message-ID: <m3irzhh3v0.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> writes:

> +/*
> + * Smooth the data sequence by estimating the slope for the data sequence
> + * [x3, x2, x1, x0] by using linear regression to fit a line to the data and
> + * use the slope of the line. Taken from the synaptics X driver.
> + */

This comment is not correct now that the code uses floating average
instead. Maybe just remove it. The floating average calculation is
much more obvious than the linear regression stuff.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
