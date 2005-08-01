Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVHAJ5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVHAJ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVHAJ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:57:16 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:16339 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262095AbVHAJ4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:56:51 -0400
Date: Mon, 1 Aug 2005 11:56:50 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
Message-ID: <20050801095650.GA21132@janus>
References: <20050729162006.GA18866@janus> <Pine.LNX.4.61.0507302017400.3459@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507302017400.3459@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 08:27:24PM +0100, Hugh Dickins wrote:
> On Fri, 29 Jul 2005, Frank van Maarseveen wrote:
> > 2.6.13-rc4 does not recognize the second CPU of a 3GHz HT P4:
> 
> I think your problem is this: HT has depended on CONFIG_ACPI for
> some while, and now in 2.6.13-rc CONFIG_ACPI depends on CONFIG_PM.
> You don't have CONFIG_PM set in your .config (nor had I), so you
> don't get ACPI, so you don't get HT.

enabling PM fixed HT problem, thanks.

-- 
Frank
