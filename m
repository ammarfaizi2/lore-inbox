Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUGGWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUGGWfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUGGWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:35:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49536 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265574AbUGGWf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:35:27 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "John W. Ross" <programming@johnwross.com>
Subject: Re: Increasing IDE Channels
Date: Thu, 8 Jul 2004 00:41:07 +0200
User-Agent: KMail/1.5.3
References: <001801c46470$94116820$0a01a8c0@jwrdesktop>
In-Reply-To: <001801c46470$94116820$0a01a8c0@jwrdesktop>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407080041.07508.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ next time please use/cc linux-ide ML ]

On Thursday 08 of July 2004 00:20, John W. Ross wrote:
> Greetings,

Hi,

> Changed ide.h:
>
> IDE_NR_PORTS  (10)
> to
> IDE_NR_PORTS  (12)

You've changed the wrong define.  Bump MAX_HWIFS in <asm/ide.h> instead.

> 1.) Could someone please explain why there is a limit of 10 interfaces (is
> this something that I shouldn't even try)?

- there are no more major numbers assigned for IDE
- for majority people of people it is enough
- IDE driver uses static data structures so higher number of interfaces
  means more memory wasted (if you don't use all of them of course)
- nobody cared

> 2.)What did I miss on moving to 12?

It should work with MAX_HWIFS corrected.

> 3.) I could understand a limit of 12, as hda, hdb, hdc... hdw, hdx, would
> only allow a possible 13th interface, but at 14 you would totally exhaust
> the alphabet, but is that still relevant with the newer method of
> enumerating partitions?

What newer method are you talking about?

Regards,
Bartlomiej

