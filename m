Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUGNShO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUGNShO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUGNShC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:37:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38854 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267502AbUGNSgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:36:17 -0400
Message-ID: <40F57D14.9030005@pobox.com>
Date: Wed, 14 Jul 2004 14:36:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141751.i6EHprhf009045@harpo.it.uu.se>
In-Reply-To: <200407141751.i6EHprhf009045@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> It's needed, and no it's not a compiler bug.

In fact, it is.  gcc isn't properly inlining functions where uses occur 
before implementation of the inlined function.

Or you could just call it "gcc is dumb" rather than a compiler bug.

	Jeff


