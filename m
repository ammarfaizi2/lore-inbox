Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVKAEUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVKAEUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVKAEUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:20:19 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:5527 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932572AbVKAEUR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:20:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BOnAZcPUuwtIcU30gssuVT8aV5+4sg2qXc6quI8RE0TZkc+vHZJSSKomsabxCaK0zT3i9FvhYz2ntCEBovE0HtSCZ5vv1/9B3VWj7eUryiYR10CpzS3HPFrDEOIJVSjl6tgBX2XHBj9h/b0RGTId1vCaw9yOy0KKC659dzEMYlw=
Message-ID: <7e77d27c0510312020i435a80v@mail.gmail.com>
Date: Tue, 1 Nov 2005 12:20:17 +0800
From: Yan Zheng <yzcorp@gmail.com>
To: David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]IPv6: Check packet size when process Multicast Address and Source Specific Query
Cc: Yan Zheng <yanzheng@21cn.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <OF1A55BA31.24DA7F68-ON882570AB.006BBA0E-882570AB.006C3CFC@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4365A995.3050404@21cn.com>
	 <OF1A55BA31.24DA7F68-ON882570AB.006BBA0E-882570AB.006C3CFC@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this should be modelled after the equivalent code in IGMPv3.
> See igmp_heard_query() in net/ipv4/igmp.c. For ease of maintenance,
> the code should be structured exactly the same way, except for
> necessary differences, of course.
>
> I haven't seen enough context yet, but  I think you need to check
> for the query header itself, too (as done in IGMPv3).
>
> I'm reviewing your other patches as well.
>
>                                         +-DLS

Yes .  It's  better to drop invalid query earlier.
