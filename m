Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269202AbTGOR5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbTGOR5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:57:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28359
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269252AbTGORy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:54:27 -0400
Subject: Re: [patch] vesafb fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20030715175358.GB15505@suse.de>
References: <20030715141023.GA14133@bytesex.org>
	 <20030715173557.GB1491@mail.jlokier.co.uk> <20030715175358.GB15505@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058292400.3845.59.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 19:06:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 18:53, Dave Jones wrote:
>  > The latter failed because it's not suitably aligned - i.e. there was a
>  > problem in th logic which splits non-power-of-two regions.
>  > Is that fixed these days?
> 
> Better would be to use change_page_attr to manipulate PAT bits.
> We then wouldn't have to worry at all about alignment, running out
> of MTRRs, or collisions with other MTRRs.

Not all the MTRR using chips use PAT - but its certainly a start. The
base algorithm for allocating MTRRs as efficiently as sanely possible
is already in the kernel btw - or pretty close to it - its used by
the Winchip code to cover RAM with out of order store.

