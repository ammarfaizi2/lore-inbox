Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWH1LZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWH1LZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWH1LZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:25:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1950 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964824AbWH1LZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:25:51 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       linux-tiny@selenic.com, devel@laptop.org
In-Reply-To: <44F2CB09.2010809@aitel.hist.no>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <200608251611.50616.rob@landley.net>
	 <1156538115.3038.6.camel@pmac.infradead.org>
	 <44F2CB09.2010809@aitel.hist.no>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 12:21:16 +0100
Message-Id: <1156764076.5340.75.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 12:52 +0200, Helge Hafting wrote:
> And a "make optImage" (optimized image) when building a
> kernel for production use, when you believe compiling every file
> and spending lots of extra time is worth it. 

If we revamp the entire kbuild infrastructure to allow building the
_whole_ kernel with --combine then I might be inclined to agree -- we
could do that instead of a CONFIG_COMBINED_COMPILE option.

But if, as I suggest, we're doing the simple option which combines only
the files which tend to get most benefit from it -- those which are in
the same directory -- then there's not a lot of point in the separate
target. It really doesn't take that much extra time.

-- 
dwmw2

