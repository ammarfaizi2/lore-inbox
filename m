Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbUCTBOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUCTBOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:14:51 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:54340 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263209AbUCTBOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:14:50 -0500
Date: Fri, 19 Mar 2004 17:14:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040319171404.6f79b08a.pj@sgi.com>
In-Reply-To: <20040319164726.02e5f417.pj@sgi.com>
References: <1BeOx-7ax-55@gated-at.bofh.it>
	<1BgGq-DU-5@gated-at.bofh.it>
	<1BgZN-Vk-1@gated-at.bofh.it>
	<m37jxhvbgm.fsf@averell.firstfloor.org>
	<1079737773.17841.67.camel@arrakis>
	<20040319164726.02e5f417.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                bitmask_and(d._m, s1._m, s2._m);        \

Oops - need the size argument to bitmask_and:

		bitmask_and(d._m, s1._m, s2._m, sizeof(d)*8);        \

(I only tested the 1 word case earlier ...)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
