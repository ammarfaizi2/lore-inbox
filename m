Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWEJJ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWEJJ0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWEJJ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:26:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:45718 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964871AbWEJJ0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:26:46 -0400
Message-ID: <4461B24A.7050805@suse.de>
Date: Wed, 10 May 2006 11:28:42 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc3 -- SMP alternatives: switching to UP code
References: <4461341B.7050602@keyaccess.nl>
In-Reply-To: <4461341B.7050602@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Hi list.
> 
> I just noticed this in the 2.6.17-rc3 dmesg:
> 
> ===
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> Freeing SMP alternatives: 0k freed
> ACPI: setting ELCR to 0400 (from 1608)
> ===
> 
> Should I be seeing this "SMP alternatives" thing on a !CONFIG_SMP
> kernel? It does say 0k, but something is apparently being done at
> runtime still. Why?

The UP kernel has empty alternatives tables (as you've noticed), thus
the code doesn't do anything.  Nevertheless it probably makes sense to
add a few #ifdef CONFIG_SMP lines to avoid confusing people and safe a
few bytes ...

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg
