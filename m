Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUHYU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUHYU74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268684AbUHYU5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:57:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:35614 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268602AbUHYUu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:50:29 -0400
Date: Wed, 25 Aug 2004 22:51:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040825205113.GA7258@mars.ravnborg.org>
Mail-Followup-To: pmarques@grupopie.com,
	linux-kernel@vger.kernel.org, bcasavan@sgi.com
References: <1093406686.412c0fde79d4f@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093406686.412c0fde79d4f@webmail.grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 05:04:46AM +0100, pmarques@grupopie.com wrote:
> 
> This patch is an improvement over my first kallsyms speedup patch posted about 2
> weeks ago.

My origianl comment still hold.
Decoupling the compression and decompression part is not good.
Better keep them close to each other.

Why not put all symbols in an __init section, compress them during kernel boot
and then the original section get discarded.

After a quick browse of the code.
- Use spaces around '=' etc.

	Sam

