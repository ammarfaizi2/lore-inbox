Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUG1M32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUG1M32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUG1M32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:29:28 -0400
Received: from adsl-63-231.38-151.net24.it ([151.38.231.63]:50954 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S266892AbUG1M31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:29:27 -0400
Date: Wed, 28 Jul 2004 14:29:25 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dominik Karall <dominik.karall@gmx.net>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Daniele Venzano <webvenza@libero.it>
Subject: Re: SiS900: NULL pointer encountered in Rx ring, skipping
Message-ID: <20040728122925.GD23762@gateway.milesteg.arr>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Dominik Karall <dominik.karall@gmx.net>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Daniele Venzano <webvenza@libero.it>
References: <200407232052.06616.dominik.karall@gmx.net> <41067418.9020000@pobox.com> <200407271814.59859.dominik.karall@gmx.net> <41068126.3000009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41068126.3000009@pobox.com>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.26-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 12:21:58PM -0400, Jeff Garzik wrote:
> The OOM problem is completely unrelated to the network, therefore no 
> reset should ever be considered for this condition.
> 
> The driver should properly handle the 'NULL in rx ring' condition as a 
> normal occurence.  It should skip to the next available skb in the ring. 
>  If no skbs are remain, it should drop the skb.
> 
> See natsemi.c for additional -- and optional -- OOM handling techniques.
> 
> 	Jeff

I will check this for the sis900 driver.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

