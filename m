Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWHXPSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWHXPSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWHXPSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:18:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:20625 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964975AbWHXPSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:18:53 -0400
From: Andi Kleen <ak@suse.de>
To: schwidefsky@de.ibm.com
Subject: Re: [patch] dubious process system time.
Date: Thu, 24 Aug 2006 17:18:29 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060824121825.GA4425@skybase> <p731wr6fh54.fsf@verdi.suse.de> <1156426103.28464.29.camel@localhost>
In-Reply-To: <1156426103.28464.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241718.29406.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> At the moment hardirq+softirq is just added to a random process, in
> general this is completely wrong. 

It's better than not accounting it at all.

> You just need a system with a cpu hog 
> and an i/o bound process and you get queer results.

Yes, but system load that is invisible to standard monitoring
tools is even worse.

If you stop accounting it to random processes you have to 
account it somewhere else. Preferably somewhere that standard tools
automatically pick up.

-Andi
