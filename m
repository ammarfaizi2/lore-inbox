Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUITRqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUITRqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUITRqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:46:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26849 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266884AbUITRqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:46:37 -0400
Date: Mon, 20 Sep 2004 13:19:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: joshk@triplehelix.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] scripts: Support output of new ld
Message-ID: <20040920161913.GC4501@logos.cnet>
References: <20040918065733.GA4549@darjeeling.triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20040918065733.GA4549@darjeeling.triplehelix.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Joshua, 

(We met at Palo Alto in a Debian dinner on a chinese restaurant, remember? :))


Unfortunately this patch doenst apply cleanly

[marcelo@logos linux-2.4]$ fp /tmp/gnu
bk import -tpatch -r -CR -yscripts: Support output of new ld /tmp/patch4572 .
Patching...
Patch failed.  **** patch log follows ****
Patching file scripts/ver_linux
1 out of 1 hunk FAILED -- saving rejects to file scripts/ver_linux.rej

Its easy enough to be applied by hand but I prefer if you generate
a clean patch instead

reject file attached



On Fri, Sep 17, 2004 at 11:57:33PM -0700, Joshua Kwan wrote:
> Hello,
> 
> This is one in a handful of small patches that I'll be sending along in
> the near future. This patch allows scripts/ver_linux to find out the ld
> version for versions of ld that have different output on 'ld -v' (new
> ones have "GNU" at the beginning.)
> 
> Marcelo, please apply. 
> 
> Signed-off-by: Joshua Kwan <joshk@triplehelix.org>
> 
> -- 
> Joshua Kwan
> 
> --- a/scripts/ver_linux	2004-09-05 01:31:23.000000000 -0700
> +++ b/scripts/ver_linux	2004-09-05 01:31:47.000000000 -0700
> @@ -22,7 +22,8 @@
>        '/GNU Make/{print "Gnu make              ",$NF}'
>  
>  ld -v 2>&1 | awk -F\) '{print $1}' | awk \
> -      '/BFD/{print "binutils              ",$NF}'
> +      '/BFD/{print "binutils              ",$NF}
> +       /^GNU/{print "binutils              ",$4}'
>  
>  fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
>  



--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ver_linux.rej"

***************
*** 22,28 ****
        '/GNU Make/{print "Gnu make              ",$NF}'
  20
  ld -v 2>&1 | awk -F\) '{print $1}' | awk \
-       '/BFD/{print "binutils              ",$NF}'
  20
  fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
  20
--- 22,29 ----
        '/GNU Make/{print "Gnu make              ",$NF}'
  20
  ld -v 2>&1 | awk -F\) '{print $1}' | awk \
+       '/BFD/{print "binutils              ",$NF}
+        /^GNU/{print "binutils              ",$4}'
  20
  fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
  20

--RnlQjJ0d97Da+TV1--
