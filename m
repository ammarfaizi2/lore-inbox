Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVBNWjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVBNWjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVBNWjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:39:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:26093 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261389AbVBNWjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:39:13 -0500
Subject: Re: Radeon FB troubles with recent kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, adaplas@pol.net
In-Reply-To: <20050214203902.GH15058@waste.org>
References: <20050214203902.GH15058@waste.org>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 09:38:43 +1100
Message-Id: <1108420723.12740.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 12:39 -0800, Matt Mackall wrote:
> On my Thinkpad T30 with a Radeon Mobility M7 LW, I get interesting
> console video corruption if I start GDM, switch back to text mode,
> then stop it again. X is Xfree86 from Debian/unstable or X.org 6.8.2.
> 
> The corruption shows up whenever the console scrolls after X has been
> shut down and manifests as horizontal lines spaced about 4 pixel rows
> apart containing contents recognizable as the X display. Switch from
> vt1 to vt2 and back or visual bell clears things back to normal, but
> corruption will reappear on the next scroll.
> 
> This has appeared in at least 2.6.11-rc3-mm2 and rc4.

Appeared ? hah... that's strange. X is known to fuck up the chip when
quit, but I wouldn't have expected any change due to the new version of
radeonfb. From what you describe, it looks like an offset register is
changed by X, or the surface control.

My patch did not change any of radeonfb accel code though...

I'll catch up with you on IRC ...

Ben.


