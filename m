Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWD1MAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWD1MAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWD1MAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:00:08 -0400
Received: from mail.axxeo.de ([82.100.226.146]:53993 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1030295AbWD1MAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:00:06 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: David =?utf-8?q?G=C3=B3mez?= <david@pleyades.net>
Subject: Re: IP1000 gigabit nic driver
Date: Fri, 28 Apr 2006 13:59:47 +0200
User-Agent: KMail/1.7.2
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, David Vrabel <dvrabel@cantab.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20060427142939.GA31473@fargo> <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo>
In-Reply-To: <20060428113755.GA7419@fargo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604281359.47321.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Gómez wrote:
> On Apr 28 at 01:58:04, Pekka Enberg wrote:
> > Needs some serious coding style cleanup and conversion to proper 2.6
> > APIs for starters.
> 
> Ok, i could take care of that, and it's a good way of getting my hands
> dirty with kernel programming ;). David, if it's ok to you i'll do the
> cleanup thing.

Have fun! Great that you do this.
 
> What about 2.4/2.2 code? It's supposed to stay for compatibility
> or it should be removed before submitting?

Usually it should be removed.

The way to remove 2.4/2.2. code is by reimplementation
of 2.6-APIs in seperate files and headers and not submitting
these into latest kernel. Keep these somewhere else 
(e.g. a project web site).

That way your drivers ALWAYS work with latest kernels
and you notice breakage of backward compatiblity quite easily.
If maintaining these parts becomes a pain with no gain, 
you can simply stop providing these yourself.

"#ifdef KERNEL_VERSON" stuff in submitted drivers
is generally not acceptable. Since it is hard to test these parts.

I ported some off-tree drivers from 2.2 to 2.4. using this technique
and it works good, reduces maintainence burden and keeps
your driver current to latest APIs automatically.


Regards

Ingo Oeser
