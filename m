Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUIFTaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUIFTaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUIFTaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:30:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:12295 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268490AbUIFT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:27:51 -0400
Date: Mon, 6 Sep 2004 20:27:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK pull] DRM macro removal the end..
Message-ID: <20040906202743.A8923@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409061300020.30423@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409061300020.30423@skynet>; from airlied@linux.ie on Mon, Sep 06, 2004 at 01:02:08PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Fixup ffb driver and interfaces it uses, also avoid bus_to_virt
>    on sparc, I'll look into using the proper APIs for the DRM soon.

Umm, virt_to_bus isn't defined on other platforms aswell.  E.g. drm still
doesn't compile on ppc64.  Please revert that change completely, obviously
drm did work before without the virt_to_bus addition.

