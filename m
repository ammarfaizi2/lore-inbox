Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755451AbWKNHFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbWKNHFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbWKNHFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:05:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:46001 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1755451AbWKNHFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:05:08 -0500
X-Authenticated: #14349625
Subject: Re: [ltp] Re: paging request BUG in 2.6.19-rc5 on resume - X60s
From: Mike Galbraith <efault@gmx.de>
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061113193443.GF7942@gimli>
References: <20061113081147.GB5289@gimli>
	 <1163426119.5871.26.camel@Homer.simpson.net>  <20061113193443.GF7942@gimli>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 08:06:10 +0100
Message-Id: <1163487970.16079.15.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 20:34 +0100, Martin Lorenz wrote:

> c016ff96 <unlock_new_inode>:
> c016ff96:       83 a0 2c 01 00 00 b7    andl   $0xffffffb7,0x12c(%eax)
> c016ff9d:       e9 e0 ff ff ff          jmp    c016ff82 <wake_up_inode>

Ok, that's what I figured it had to be with that mask (though I can't
convince either of my compilers to produce that offset), so now we just
have to figure out how the heck it can get there and find a corrupted
pointer.

Can you enable frame-pointers, and capture another explosion?  A more
complete trace might help.  It would definitely help to reproduce
without the proprietary modules having ever been loaded.  

	-Mike

