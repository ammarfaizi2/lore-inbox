Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVFWIjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVFWIjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbVFWIgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:36:47 -0400
Received: from isilmar.linta.de ([213.239.214.66]:23986 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262151AbVFWIEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:04:02 -0400
Date: Thu, 23 Jun 2005 10:04:00 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PCMCIA: Statically linked CF card driver?
Message-ID: <20050623080400.GA4309@isilmar.linta.de>
Mail-Followup-To: kus Kusche Klaus <kus@keba.com>,
	linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <AAD6DA242BC63C488511C611BD51F367323249@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323249@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

- use 2.6.12-mm1, and build all you need into the kernel
- in drivers/pcmcia/ds.c , remove the following block:

                /* also, FUNC_ID matching needs to be activated by userspace
                 * after it has re-checked that there is no possible module
                 * with a prod_id/manf_id/card_id match.
                 */
                if (!dev->allow_func_id_match)
                        return 0;

- it should(tm) work then... though I haven't and can't try it myself.

On Thu, Jun 23, 2005 at 09:39:15AM +0200, kus Kusche Klaus wrote:
> * Any chance to boot from it?

> * It would be nice to be able to replace the CF 
>   without rebooting.

I'm not sure whether these two aspects exclude each other.

	Dominik
