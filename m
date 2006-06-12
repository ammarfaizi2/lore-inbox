Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWFLRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWFLRhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFLRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:37:36 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:9097
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751089AbWFLRhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:37:20 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 built-in command line
Date: Mon, 12 Jun 2006 19:36:34 +0200
User-Agent: KMail/1.9.1
References: <20060611215530.GH24227@waste.org> <e6k7ak$gpd$1@terminus.zytor.com>
In-Reply-To: <e6k7ak$gpd$1@terminus.zytor.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121936.35042.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 19:12, H. Peter Anvin wrote:
> > +#ifdef CONFIG_CMDLINE_BOOL
> > +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > +#endif
> > +
> >  	/* Save unparsed command line copy for /proc/cmdline */
> >  	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
> >  
> 
> NAK.
> 
> a. Please make the patch available for x86-64 as well as x86.  The two
> are coupled enough that they need to agree.
> 
> b. This patch will override a user-provided command line if one
> exists.  This is the wrong behaviour; instead, the builtin command
> line should only apply if no user-specified command line is present.

I would say a user supplied cmd line should be appended to the
built-in cmd line.

-- 
Greetings Michael.
