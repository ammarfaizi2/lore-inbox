Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVBFSIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVBFSIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBFSIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:08:20 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:61125 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261265AbVBFSIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:08:05 -0500
Date: Sun, 6 Feb 2005 18:03:08 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Paul Mundt <lethal@linux-sh.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add as-option to top-level Makefile
Message-ID: <20050206180308.GA21172@linux-mips.org>
References: <20050206170347.GB27853@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206170347.GB27853@linux-sh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 07:03:47PM +0200, Paul Mundt wrote:

> cc-option can presently not be used for checking as flags. It seems like
> MIPS ran into this already and added their own as-option (which at this
> point seems to be completely unused on MIPS, so perhaps it's worth
> removing entirely from there).
> 
> This patch moves the definition to the top-level Makefile so that others
> can make use of it (sh wants this with newer binutils that allow for ISA
> tuning, for instance).
> 
> Additionally, it may make more sense to move the -Wa$(comma) stuff into
> as-option directly so it doesn't get repeated all over the place (though
> it seems unlikely that there will be enough users that actually care
> about this).

For MIPS as-option became unused when old binutils versions finally had to
be retired.  Patch looks good to me but since it's sort of a no-op patch I
won't merge it into linux-mips.org but if accepted rather wait until it
comes to me vi Linus's patches, as usual.

Thanks,

  Ralf
