Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUBSQPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUBSQPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:15:16 -0500
Received: from gprs157-229.eurotel.cz ([160.218.157.229]:33664 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267341AbUBSQPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:15:06 -0500
Date: Thu, 19 Feb 2004 17:14:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Message-ID: <20040219161455.GC259@elf.ucw.cz>
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org> <20040219072629.GB467@openzaurus.ucw.cz> <opr3l0mfdw4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr3l0mfdw4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I actually would like to rename the bit PG_nosave to PG_donttouch ;)
> 
> to make a point with regard to:
> 
> 	no transfer of page contents during suspend/resume
> 	no netdump
> 	no debugger access without override
> 
> ... but the name does not matter and we do not have to change it.
> 
> >Its used for swsusp internal data, too...
> 
> Yes of course - how else would swsusp run, but these data are also not  
> "touched"
> during suspend and resume wrt transfer of page content.

Yes. But I still want to be able to access swsusp internal data
through debugger, and I want them in the netdump.

That means that PG_nosave | PG_reserved indeed is "PG_donttouch", but
PG_nosave has slightly different meaning.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
