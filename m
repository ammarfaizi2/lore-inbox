Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUIGV3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUIGV3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIGV1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:27:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:58793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268669AbUIGVZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:25:40 -0400
Date: Tue, 7 Sep 2004 14:23:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
Message-Id: <20040907142338.73b2d1c6.akpm@osdl.org>
In-Reply-To: <200409072004.03343.blaisorblade_spam@yahoo.it>
References: <20040906174447.238788D1E@zion.localdomain>
	<20040906142641.067fdeb6.akpm@osdl.org>
	<200409072004.03343.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> On Monday 06 September 2004 23:26, Andrew Morton wrote:
>  > Please don't use a filename like uml-ubd-no-empty-queue as the Subject:
>  > of your patches.  Please prepare an English-language summary.  See
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>  Ok, but how can I specify the filename you'll give to the patch?
> 
>  It would make management between my tree and yours easier for me, if possible.

hm.  By choosing a suitable Subject:, I guess.

Start the Subject with "uml:" and then avoid getting fancy in the rest of
the subject and things should work out OK.  Spaces and other funny
characters are replaced with "-" and underscores are retained.

I use the below piece of ad-hoc revoltium to canonicalise Subject:s into
filenames:

line=$(echo "$line" | tr 'A-Z' 'a-z')
line=$(echo "$line" | sed -e 's/^subject:[ 	]*//')
line=$(echo "$line" | sed -e 's/^fw:[ 	]*//')
line=$(echo "$line" | sed -e 's/^fwd:[ 	]*//')
line=$(echo "$line" | sed -e 's/^aw:[ 	]*//')
line=$(echo "$line" | sed -e 's/^re:[ 	]*//')

line=$(echo "$line" | sed -e 's/^patch//')
line=$(echo "$line" | sed -e "s/['\(\)\<\>\{\}\,\.\\]//g")
line=$(echo "$line" | sed -e "s/[\#\*\&\+\^\!\~\`\:\?\;]//g")
line=$(echo "$line" | sed -e "s/[\$]//g")
line=$(echo "$line" | sed -e 's/"//g')
line=$(echo "$line" | sed -e 's/^[-]*//g')
line=$(echo "$line" | sed -e 's/\[[^]]*\]//g')
line=$(echo "$line" | sed -e 's/[ 	]*\[patch\][	]*//')
line=$(echo "$line" | sed -e 's/\[//g')
line=$(echo "$line" | sed -e 's/\]//g')
line=$(echo "$line" | sed -e 's/^[ 	]*//')
line=$(echo "$line" | sed -e 's/ -/-/g')
line=$(echo "$line" | sed -e 's/- /-/g')
line=$(echo "$line" | sed -e 's/[ 	][ 	]*/-/g')
line=$(echo "$line" | sed -e 's,/,-,g')
line=$(echo "$line" | sed -e 's/--/-/g')
line=$(echo "$line" | sed -e 's/-$//g')
line=$(echo "$line" | sed -e 's/^-//g')

