Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVEYH63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVEYH63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVEYH63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:58:29 -0400
Received: from general.keba.co.at ([193.154.24.243]:58483 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262297AbVEYH6U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:58:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: RT patch acceptance
Date: Wed, 25 May 2005 09:58:17 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F36732321E@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT patch acceptance
Thread-Index: AcVgdo04bY5xJH90QvaO2kQF8z1q7QAgFsnA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, "K.R. Foley" <kr@cybsft.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Christoph Hellwig" <hch@infradead.org>,
       "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, <sdietrich@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> K.R. Foley wrote:
> 
> > There are definitely those who would prefer to have the 
> functionality,
> > at least as an option, in the mainline kernel. The group 
> that I contract
> > for get heartburn about having to patch every kernel 
> running on every
> > development workstation and every production system. We 
> need hard RT,
> > but currently when we have to have hard RT we go with a different
> > product.
> 
> Well, yes. There are lots of things Linux isn't suited for.
> There are likewise a lot of patches that SGI would love to
> get into the kernel so it runs better on their 500+ CPU
> systems. My point was just that a new functionality/feature
> doesn't by itself justify being included in the kernel.org
> kernel.

I would like to throw in my (and my employer's) point of view,
which is the point of view of a potential user of RT linux,
not the view of a kernel developer.

We are currently evaluating the suitability of Linux for
industrial control systems.

We strongly opt for having RT in the standard kernel,
not as a separate patch. 
It will surely make a big difference for our final decision.

>From the engineer's point of view:

* Adding one patch to the kernel is usually quite trivial.

  However, adding several big patches to the kernel is a
  major PITA: They are usually based on different versions
  of the base kernel, they collide and usually need some manual 
  merging, they have not been tested together, they cause the
  number of updates to explode exponentially (a critical fix of
  any of the patches involved forces a rebuild of the whole thing), 
  and so on.

  Currently, we have to integrate the RT patch, some debugging
  patches (like kgdb), additional device drivers and protocols
  (e.g. CANbus), and probably more in future.

  Hence, having as many features as possible in the standard kernel
  instead of in separate patches would be a major relief, and would 
  simplify using linux a lot.

>From the management's point of view:

* Mgmt has to pay for the staff doing this patching and integration,
  which causes additional costs (and delays the product).
  Currently, our products are based on a commercial realtime OS, 
  which works out of the box - Linux has to compete with that.

* Something being "a patch" makes a big difference in attitude:

  Mgmt strongly resists to base the success of our company on patches.
  "Patch" sounds hacky, quick & dirty, temporary, ...
  "Standard" sounds a lot more reliable, solid, proven, well-done.

  For its decision, the mgmt wants a clear indication that RT linux
  is something which is expected to exist and to be maintained
  for years, not just some quick hack to demonstrate the principle.
  Being in the standard kernel would clearly indicate a commitment
  that RT linux is there to stay.

Greetings

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
