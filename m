Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVDOJow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVDOJow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 05:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVDOJo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 05:44:26 -0400
Received: from hermes.domdv.de ([193.102.202.1]:37903 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261787AbVDOJoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 05:44:18 -0400
Message-ID: <425F8CE6.90200@domdv.de>
Date: Fri, 15 Apr 2005 11:44:06 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Stefan Seyfried <seife@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org>
In-Reply-To: <20050414195352.GM3174@waste.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> Zero only the mlocked regions. This should take essentially no time at
> all. Swsusp knows which these are because they have to be mlocked
> after resume as well. If it's not mlocked, it's liable to be swapped
> out anyway.

Nitpicking:
What happens if the disk decides to relocate a close to failing sector
containing mlocked data during resume zeroing? This just means that
there will be sensitive data around on the disk that can't be  zeroed
out anymore but which might be recovered by specialized
companies/institutions.
Encrypting these data in the first place reduces this problem to a
single potentially problematic sector.
If this risk is then still too high for you then there's always the
possiblity to use a sledgehammer :-)
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
