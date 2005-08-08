Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVHHKoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVHHKoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVHHKoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:44:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:57263 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750790AbVHHKoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:44:04 -0400
Subject: Re: pselect() modifying timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: David Woodhouse <dwmw2@infradead.org>, drepper@redhat.com,
       jakub@redhat.com, linux-kernel@vger.kernel.org,
       bert.hubert@netherlabs.nl, michael.kerrisk@gmx.net, akpm@osdl.org
In-Reply-To: <31556.1123238544@www44.gmx.net>
References: <1118835415.22181.68.camel@hades.cambridge.redhat.com>
	 <31556.1123238544@www44.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Aug 2005 12:10:12 +0100
Message-Id: <1123499412.28681.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-05 at 12:42 +0200, Michael Kerrisk wrote:
> 1. POSIX made the behaviour of pselect() explicit -- the 
>    timeout must not be modified.  The idea was to avoid the 
>    vagueness of the select() specification; it had to be vague 
>    because of existing implementations. By contrast, there were 

Unfortunately it made the wrong choice with pselect, as Linux select
experience has shown the modified timeout is *very* useful data to some
applications. So the patch is better than the POSUX behaviour. The
library can wrap it to provide the poorer standards compliant API while
not stopping people using the better one for Linux specific apps.

