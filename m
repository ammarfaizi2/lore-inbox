Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271729AbTHDNOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271730AbTHDNOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:14:41 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51867 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271729AbTHDNOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:14:40 -0400
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel
	from being modified easily
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: David Lang <david.lang@digitalinsight.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devik@cdi.cz,
       aebr@win.tue.nl
In-Reply-To: <20030803214738.GA16129@outpost.ds9a.nl>
References: <20030803140031.7665546c.akpm@osdl.org>
	 <Pine.LNX.4.44.0308031425100.24695-100000@dlang.diginsite.com>
	 <20030803214738.GA16129@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060002642.416.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Aug 2003 14:10:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 22:47, bert hubert wrote:
> As to what Alan said about LSM, I've yet to see how to do that in a
> reasonable way. But I didn't look too hard.

Just refuse anything needing CAP_SYS_RAWIO at all times. Thats why this
capability flag exists. Or with SELinux you can create a role which has
RAWIO access but is very limited in other ways (eg "Only my X server",
or "only the firmware loader for my serial card") and which is tainted
if anything else touches those files

Alan

