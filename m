Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUHQFHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUHQFHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUHQFHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:07:07 -0400
Received: from holomorphy.com ([207.189.100.168]:41644 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268104AbUHQFHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:07:00 -0400
Date: Mon, 16 Aug 2004 22:06:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-ID: <20040817050642.GK11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
	kai@germaschewski.name, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org> <20040815150635.5ac4f5df.akpm@osdl.org> <200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 02:02:21AM -0400, Jeff Dike wrote:
> The undefined symbol checking is continuing to cause UML pain.  This time,
> it picked up a bunch of 'w' symbols as undefined.  They were present in the
> 2.6.8-rc4-mm1 vmlinux and caused no problems for the final link, so I added
> them as a second special case to mksysmap (and I just noticed that I forgot
> a comment there - I can submit a patch for that if there's demand for one).

Likewise for sparc64; the 'w' symbols are showing up as 'undefined'
there too. Probably because [^w] isn't behaving as expected.


-- wli
