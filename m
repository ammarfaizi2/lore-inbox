Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVDKG6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDKG6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVDKG6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:58:48 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:10902 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261708AbVDKG6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:58:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Oops in swsusp
Date: Mon, 11 Apr 2005 08:59:00 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <4259B425.4090105@domdv.de>
In-Reply-To: <4259B425.4090105@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504110859.00961.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 of April 2005 01:17, Andreas Steinmetz wrote:
> Pavel,
> during testing of the encrypted swsusp_image on x86_64 I did get an Oops
> from time to time at memcpy+11 called from swsusp_save+1090 which turns
> out to be the memcpy in copy_data_pages() of swsusp.c.
> The Oops is caused by a NULL pointer (I don't remember if it was source
> or destination).

It's quite important, however.  If it's the destination, it's probably a bug in
swsusp.  Otherwise, the problem is more serious.  Could you, please,
add BUG_ON(!pbe->address) right before the memcpy() and retest?

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
