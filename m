Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUEXV77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUEXV77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEXV77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:59:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:3237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263831AbUEXV75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:59:57 -0400
Date: Mon, 24 May 2004 14:49:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Cef (LKML)" <cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [announce/OT] kerneltop ver. 0.7
Message-Id: <20040524144946.52a356cc.rddunlap@osdl.org>
In-Reply-To: <200405241955.43938.cef-lkml@optusnet.com.au>
References: <20040523215027.5dc99711.rddunlap@osdl.org>
	<20040524053153.GM1833@holomorphy.com>
	<200405241955.43938.cef-lkml@optusnet.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004 19:55:42 +1000 Cef (LKML) wrote:

| On Mon, 24 May 2004 15:31, William Lee Irwin III wrote:
| > On Sun, May 23, 2004 at 09:50:27PM -0700, Randy.Dunlap wrote:
| > > just a little note about kerneltop...
| > > 'kerneltop' is similar to 'top', but shows only kernel function usage
| > > (modules not included).
| > > I have updated it a bit (now version 0.7) and made sure that it
| > > works OK on Linux 2.6.x.
| > > It's available here:
| > > 	http://www.xenotime.net/linux/kerneltop/
| >
| > GRRR.. this tries to reset /proc/profile. Multiple megabytes of in-
| > kernel memset() at a frequency of 1Hz are extremely unfriendly.
| 
| Following patch primes the buffer first time round (avoids huge total_ticks on 
| first pass) and moves total_ticks to the end of the field header bar, saving 
| an output line for useful data.
| 
| PS: If this keeps going, we should probably take this off-list or move to 
| somewhere appropriate.

I applied the total_ticks heading change.  Still thinking about the
first-pass-priming-the-pump change.  It's not a big deal either way IMO.

| For clarity, you might want to invert the "address  function ....." line to 
| separate the header from the actual displayed data (like top does).

Done.

Still considering your other suggestions.  Thanks.

--
~Randy
