Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUGZUf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUGZUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUGZUfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:35:33 -0400
Received: from waste.org ([209.173.204.2]:45029 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264860AbUGZUBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:01:49 -0400
Date: Mon, 26 Jul 2004 15:01:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: Fruhwirth Clemens <clemens-dated-1091709927.ed82@endorphin.org>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040726200126.GQ5414@waste.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima> <41039CAC.965AB0AA@users.sourceforge.net> <1090761870.10988.71.camel@ghanima> <4103ED18.FF2BC217@users.sourceforge.net> <1090778567.10988.375.camel@ghanima> <4104E2CC.D8CBA56@users.sourceforge.net> <1090845926.13338.98.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090845926.13338.98.camel@ghanima>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 02:45:26PM +0200, Fruhwirth Clemens wrote:
> To summarize for an innocent bystander:
> 
> - The attacks you brought forward are in the best case a starting point
> for known plain text attacks. Even DES is secure against this attack,
> since an attacker would need 2^47 chosen plain texts to break the cipher
> via differential cryptanalysis. (Table 12.14 Applied Cryptography,
> Schneier). First, the watermark attack can only distinguish 32
> watermarks. Second, you'd need a ~2.000.000 GB to store 2^47 chosen
> plain texts. Third, I'm talking about DES (designed 1977!), no chance
> against AES.

Here's a scenario: corrupt government agency secretly watermarks
incriminating documents. Brave whistleblower puts them on his laptop's
cryptoloop fs, but gets taken aside by customs agents on his way out
of the country. Agents check his disk for evidence of the watermark
and find enough evidence to assure that he's never seen again, without
even having to resort to rubber hose techniques.

Yes, the scenario is unlikely and I think it's _way_ overstating it to
call it an exploit. But it's still worth defending against. If we're
going to change disk formats, we should try to address it.

-- 
Mathematics is the supreme nostalgia of our time.
