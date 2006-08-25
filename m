Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWHYUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWHYUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWHYUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:35:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10459 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932463AbWHYUfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:35:25 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
In-Reply-To: <200608251611.50616.rob@landley.net>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <200608251611.50616.rob@landley.net>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 21:35:15 +0100
Message-Id: <1156538115.3038.6.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 16:11 -0400, Rob Landley wrote:
> BusyBox has been doing this for months now: "build at once" is one of our 
> config options.  I'd like to point out that gcc eats needs several hundred 
> megabytes of ram to do this and you have no useful progress indicator between 
> starting and ending.  But the result is definitely smaller.

It isn't that bad when you're only building a few files at a time -- I
wouldn't suggest doing it for the whole kernel.

And you get a nice progress indicator at the moment -- a new warning
about global register variables every time it eats a new file, due to
GCC PR27899 :)

> We also tell the linker "--sort-common --gc-sections" which may or may not 
> apply here...

We want --gc-sections (which requires -ffunction-sections
-fdata-sections to be useful) but that's a separate issue. We were doing
it a long time ago for the FR-V kernel; Marcelo has been looking at it
recently for other architectures.

-- 
dwmw2

