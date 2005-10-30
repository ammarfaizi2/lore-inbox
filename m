Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbVJ3BUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbVJ3BUD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbVJ3BUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:20:03 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:24529 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S932766AbVJ3BUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:20:01 -0400
Date: Sun, 30 Oct 2005 02:19:59 +0100
From: David Weinehall <tao@acc.umu.se>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
Message-ID: <20051030011959.GA17750@vasa.acc.umu.se>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain> <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain> <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain> <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 05:06:21PM -0400, Steven Rostedt wrote:
[snip]

> Index: Ketchup-d9503020b3c1/ketchup
> ===================================================================
> --- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 08:38:50.000000000 -0400
> +++ Ketchup-d9503020b3c1/ketchup	2005-10-28 10:45:43.000000000 -0400
> @@ -482,7 +482,7 @@
>          error("Unpacking failed: ", err)
>          sys.exit(-1)
> 
> -    err = os.system("mv linux*/* . ; rmdir linux*")
> +    err = os.system("shopt -s dotglob; mv linux*/* . ; rmdir linux*")
>      if err:
>          error("Unpacking failed: ", err)
>          sys.exit(-1)


Uhm, this patch assumes that you're using bash as /bin/sh.
Not everyone does.  (I haven't checked the rest of the system calls
in ketchup though, maybe this is a more generic problem?)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
