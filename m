Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWFIVgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWFIVgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWFIVgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:36:24 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:26069 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030320AbWFIVgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:36:23 -0400
Message-ID: <4489E9D8.6090002@namesys.com>
Date: Fri, 09 Jun 2006 14:36:24 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Barry K. Nathan" <barryn@pobox.com>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060604133326.f1b01cfc.akpm@osdl.org> <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu> <20060604213432.GB5898@elte.hu> <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com> <20060605065444.GA27445@elte.hu>
In-Reply-To: <20060605065444.GA27445@elte.hu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>        if (atomic_read(&node->d_count) != 0) {
>                return 0;
>        }
>
>why the braces, when on the next line it's not done:
>
>        if (blocknr_is_fake(jnode_get_block(node)))
>                return 0;
>
>it looks quite inconsistent.
>
I have a (roughly adhered to) rule that I don't hassle programmers much
about the style of any code that I can easily read.  I truly do not care
where the braces are, I care if the comments and variable names are well
done.  So that is why, and yes, I know I am an unusual manager on this
point.
