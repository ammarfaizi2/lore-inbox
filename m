Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVCNWCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVCNWCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVCNWCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:02:54 -0500
Received: from relay.axxeo.de ([213.239.199.237]:10120 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261928AbVCNV6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:58:41 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2.6] fix mprotect() with len=(size_t)(-1) to return -ENOMEM
Date: Mon, 14 Mar 2005 22:58:01 +0100
User-Agent: KMail/1.7.1
References: <1110794148.26254.45.camel@yjin3-dev.sh.intel.com> <1110794932.6288.58.camel@laptopd505.fenrus.org>
In-Reply-To: <1110794932.6288.58.camel@laptopd505.fenrus.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503142258.01611.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

You wrote:
> shouldn't we just fix the alignment code instead that the overflow case
> doesn't align to 0???
> that sounds really odd.

How? You have to align and you are out of bits for representing the
next number. What is the next number you can round to? "null" right!

Just remember that integer math with limited bits is always ring math ;-)

I love to abuse this for buffers and save an if.

Regards

Ingo Oeser



