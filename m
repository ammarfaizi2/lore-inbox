Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752165AbWCCCdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWCCCdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCCCdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:33:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752162AbWCCCdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:33:06 -0500
Date: Thu, 2 Mar 2006 18:31:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/15] EDAC: edac_mc_add_mc() fix [1/2]
Message-Id: <20060302183143.6730d255.akpm@osdl.org>
In-Reply-To: <200603021748.07381.dsp@llnl.gov>
References: <200603021748.07381.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
>  This is part 1 of a 2-part patch set.  The code changes are split into
>  two parts to make the patches more readable.

Will the code compile and run with just #1-of-2 applied?

If not, we should combine the patches (which I can do in a jiffy).  Because
hitting a won't-compile in the middle of a git-bisect session is quite
painful.

Similarly we should aim for compiles-and-works at each step of the whole
series, if possible/sane.

>  Move complete_mc_list_del() and del_mc_from_global_list() so we can
>  call del_mc_from_global_list() from edac_mc_add_mc() without forward
>  declarations.  Perhaps using forward declarations would be better?
>  I'm doing things this way because the rest of the code is missing
>  them.

Well I prefer it the way you've done it in this patch.  But my first
language was Pascal ;)  (yes, they had computers then)

