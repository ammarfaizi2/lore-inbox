Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265896AbUAUKUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 05:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUAUKUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 05:20:08 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:39568 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265896AbUAUKUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 05:20:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 21 Jan 2004 10:59:36 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support
Message-ID: <20040121095935.GA31624@bytesex.org>
References: <20040120093054.GC18096@bytesex.org> <20040121043608.515032C090@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121043608.515032C090@lists.samba.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This provides simple forwards compat for 2.4.  It doesn't do arrays or
> strings, but they can be added if required (this will cover the easy
> 90%).

At least the array stuff I'm using in my drivers, to handle the
"multiple tv cards in one box" case, like this:

  static unsigned int card[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
  MODULE_PARM(card,"1-" __stringify(SAA7134_MAXBOARDS) "i");
  MODULE_PARM_DESC(card,"card type");

So having that in 2.4 too would be nice.

I have also two more questions:  How can I specify default values != 0
for insmod options using the new macros?  How specify help/description
texts?  Using the MODULE_PARM_DESC() macro or is there something new too?

  Gerd

