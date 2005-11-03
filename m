Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVKCXDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVKCXDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKCXDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:03:54 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:5513 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751300AbVKCXDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:03:53 -0500
Date: Fri, 4 Nov 2005 00:06:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] kconfig: update kconfig Makefile
Message-ID: <20051103230647.GA7722@mars.ravnborg.org>
References: <Pine.LNX.4.61.0511031607490.2509@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031607490.2509@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

> -$(obj)/zconf.tab.c: $(src)/zconf.tab.c_shipped
> -$(obj)/lex.zconf.c: $(src)/lex.zconf.c_shipped
They were required to support building with a seperate output directory.

make O=...
And I do not see any changes that fixes this.

They broke the build with LKC_GENPARSER set to 1 but the right fix
would be to include them in the else part instead.

	Sam
