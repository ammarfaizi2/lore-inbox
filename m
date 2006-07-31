Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWGaHnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWGaHnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGaHnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:43:33 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:45140 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964818AbWGaHnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:43:32 -0400
Message-ID: <44CDB4A0.5010805@tls.msk.ru>
Date: Mon, 31 Jul 2006 11:43:28 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 006 of 9] md: Remove the working_disks and failed_disks
 from raid5 state data.
References: <20060731172842.24323.patches@notabene> <1060731073227.24494@suse.de>
In-Reply-To: <1060731073227.24494@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> They are not needed.
> conf->failed_disks is the same as mddev->degraded

By the way, `failed_disks' is more understandable than `degraded'
in this context.  "Degraded" usually refers to the state of the
array in question, when failed_disks > 0.

That to say: I'd rename degraded back to failed_disks, here and
in the rest of raid drivers... ;)

/mjt
