Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWG0CsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWG0CsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 22:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWG0CsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 22:48:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:57325 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751202AbWG0CsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 22:48:07 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: ricknu-0@student.ltu.se
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Date: Thu, 27 Jul 2006 04:48:01 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se>
In-Reply-To: <1153945705.44c7d069c5e18@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270448.03257.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 22:28, ricknu-0@student.ltu.se wrote:
> Have not found any (real) reason letting the cpp know about false/true. As I
> said in the last version, the only reason seem to be for the userspace. Well, as
> there is no program of my knowlage that needs it, they were removed.
> 
If we don't expect this to show up in the ABI (which I hope is true), then
the definition should probably be inside of #ifdef __KERNEL__. Right
now, it's inside of (!__KERNEL_STRICT_NAMES), which is not exactly the
same.

	Arnd <><
