Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270000AbUIDA1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbUIDA1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270002AbUIDA1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:27:47 -0400
Received: from quest.jpl.nasa.gov ([137.79.96.50]:20452 "EHLO
	quest.jpl.nasa.gov") by vger.kernel.org with ESMTP id S270000AbUIDA1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:27:41 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3984177C-FE09-11D8-BDA9-000A95820F30@alumni.caltech.edu>
Content-Transfer-Encoding: 7bit
From: Mark Adler <madler@alumni.caltech.edu>
Subject: Re: [PATCH 2.6.9-rc1] ppc32: Switch arch/ppc/boot to zlib_inflate
Date: Fri, 3 Sep 2004 17:27:38 -0700
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
> The following patch switches arch/ppc/boot over from using its own
> version of zlib to the code found under lib/zlib_inflate.  The plus 
> side
> to this, is one less version of zlib stuff around in the kernel.  The
> downside is that the zlib code is ~8kB larger now, so I'm not sure if
> this is a good idea.

If I understand this correctly, you just need a small inflator for
decompression during boot.  There is such a thing that has both small
code and small memory requirements called "puff", which you can find
in zlib's contrib directory.  The only penalty is that it's about half
the speed of zlib's inflate.  But that's still pretty fast.

mark

