Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVCVARx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVCVARx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVCVARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:17:32 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:28788 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261975AbVCVAOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:14:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Date: Mon, 21 Mar 2005 18:55:43 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>, Valdis.Kletnieks@vt.edu
References: <200502240110.16521.dtor_core@ameritech.net> <200503210012.29477.dtor_core@ameritech.net> <423F507B.1090009@tuxrocks.com>
In-Reply-To: <423F507B.1090009@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211855.43537.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 17:53, Frank Sorenson wrote:
> Dmitry Torokhov wrote:
> > I have implemented arrays of groups of attributes:
> 
> Works great here.  The i8k-cumulative patch claimed to be malformed, but
> I merged it in just fine by hand.  In arch/i386/kernel/dmi_scan.c, I had
> to EXPORT dmi_get_system_info in order to get the i8k module to load.
> That may have been a mistake on my end (lots of odd patches in my tree
> right now). 

No, I bet I forgot to export it - I have i8k compiled in and would not
notice missing export.
 
> I'm a little curious to see how many people are going to 
> find they need the ignore_dmi flag versus working without it.

I want this driver to be first of all safe for loading on a random box
so it can be enabled by default.

> 
> Everything works great, and it is a big step up from the existing code.
>  I say lets go with it.
>

Yep, I will add missing export and forward it to Andrew - it could use
some time in -mm.

Thank you very much for testing it.

-- 
Dmitry
