Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752246AbWCELlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbWCELlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 06:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbWCELlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 06:41:39 -0500
Received: from natipslore.rzone.de ([81.169.145.179]:9145 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP
	id S1752175AbWCELli convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 06:41:38 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm2
Date: Sun, 5 Mar 2006 12:42:20 +0100
User-Agent: KMail/1.8
Cc: Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org,
       jketreno@linux.intel.com, "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>
References: <20060303045651.1f3b55ec.akpm@osdl.org> <20060305081442.GH29560@ens-lyon.fr> <20060305003457.48478db0.akpm@osdl.org>
In-Reply-To: <20060305003457.48478db0.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603051242.20503.stefan@loplof.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag 05 März 2006 09:34 schrieb Andrew Morton:

> That check was changed from
>
> 	"If this STA doesn't use WPA and that AP does, then bale"
>
> into
>
> 	"If this STA does use WPA and that AP doesn't then bale".
>
> So a theory would be that your AP isn't filling in those WPA length fields.
> I see no reason why we should permit that to disable WEP?

problem is that wpa_supplicant needs to set wpa_enabled unconditionally, so 
with this  change it hasn't been possible to connect to non-WPA networks 
using WPA supplicant. For the discussion on the IPW list, see 
http://marc.theaimsgroup.com/?t=114004412300002&r=1&w=2 .

1.0.12 fixes this by removing the check entirely. James: Does it makes sense 
for you to push 1.1.0 out to netdev soon, or better just the fix for this?

Stefan
