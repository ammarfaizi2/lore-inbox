Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbTHXWYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTHXWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 18:24:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21662 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261327AbTHXWYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 18:24:02 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Date: Mon, 25 Aug 2003 00:23:39 +0200
User-Agent: KMail/1.5
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1061730317.31688.10.camel@gaston>
In-Reply-To: <1061730317.31688.10.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308250023.39596.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 of August 2003 15:05, Benjamin Herrenschmidt wrote:
> Hi Bart !

Hi,

> This patch seem to have been lost, so here it is again. It fixes
> an Ooops on unregistering hwifs due to the device model now having
> mandatory release() functions. It also close the possible race we
> had on release if the entry was in use (by or /sys typically) by
> using a semaphore waiting for the release() to be called after
> doing an unregister.

I can't see the race - all references to struct device should be dropped
by driver model before finally calling ->release() function...

<...>

--bartlomiej

