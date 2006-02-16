Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWBPVvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWBPVvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBPVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:51:08 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:56713 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932485AbWBPVvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:51:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH 0/1] swsusp: fix breakage with swap on LVM
Date: Thu, 16 Feb 2006 22:51:24 +0100
User-Agent: KMail/1.9.1
Cc: "Andrew Morton" <akpm@osdl.org>, "Pavel Machek" <pavel@suse.cz>,
       "Dave Jones" <davej@redhat.com>, "LKML" <linux-kernel@vger.kernel.org>
References: <20060216161300.0C667194045@smtp.etmail.cz>
In-Reply-To: <20060216161300.0C667194045@smtp.etmail.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602162251.25298.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 February 2006 17:13, Pavel Machek wrote:
> -rc3 version looks ok, and we probably want it in asap. -mm
> version looks a bit long... --p

That's because it adds a new function + comment.

I think it's not a good idea to remake mm/swapfile.c:swap_type_of()
in a -rc3-like fashion, because it is called by the userland interface for
a different purpose and should not return non-error for the argument
being zero.

Greetings,
Rafael
