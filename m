Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWILIJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWILIJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWILIJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:09:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:26020 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965135AbWILIJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:09:42 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>, sam@ravnborg.org
Subject: Re: [development-gcc] Re: do_exit stuck
Date: Tue, 12 Sep 2006 08:32:06 +0200
User-Agent: KMail/1.9.1
Cc: "Michael Matz" <matz@suse.de>, "Richard Guenther" <rguenther@suse.de>,
       linux-kernel@vger.kernel.org
References: <200608291332.18499.ak@suse.de> <200609112217.16811.ak@suse.de> <4506767D.76E4.0078.0@novell.com>
In-Reply-To: <4506767D.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609120832.06645.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 08:57, Jan Beulich wrote:
> >Isn't a Kconfig patch missing? I don't see any place that defines
> >CONFIG_AS_CFI_SIGNAL_FRAME. Actually Kconfig wouldn't
> >be very good for this, so auto testing would be preferable
> >(like the cfi test is doing)
>
> Using that framework was the intention (you used a CONFIG_
> prefix there, and so did I), but as I wasn't sure about its status,
> and as I also was doing this against plain 2.6.18-rc6, I didn't add
> the actual detection logic. Actually I also think that should be
> done a little differently to allow for better future extension, i.e.
> instead of adding to CFLAGS store the auto-detected results in
> a header and forcibly -include it.

Ok. I guess I'll do it in the same way as the CFI detection
and maybe one of the kbuild folks can figure out a better way longer term.

BTW which binutils release started supporting this properly?

-Andi
