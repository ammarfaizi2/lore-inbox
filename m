Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWBLQx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWBLQx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBLQx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:53:58 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:29707 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751142AbWBLQx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:53:58 -0500
Date: Mon, 13 Feb 2006 00:53:36 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: Re: [RFC:PATCH 2/4] autofs4 - add v5 follow_link mount trigger method
In-Reply-To: <Pine.LNX.4.61.0602121542060.1213@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0602130052000.2319@eagle.themaw.net>
References: <200602121340.k1CDeHSn019282@eagle.themaw.net>
 <Pine.LNX.4.61.0602121542060.1213@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Feb 2006, Jan Engelhardt wrote:

> >
> >This patch adds a follow_link inode method for the root of
> >an autofs direct mount trigger. It also adds the corresponding
> >mount options and updates the show_mount method.
> >
> >+	if (sbi->type & AUTOFS_TYP_OFFSET)
> >+		seq_printf(m, ",offset");
> >+	else if (sbi->type & AUTOFS_TYP_DIRECT)
> >+		seq_printf(m, ",direct");
> >+	else
> >+		seq_printf(m, ",indirect");
> >+
> 
> Just a little nitpick: in English, it's usually "type" not "typ".

OK. But this was intentional.

In fact the same thought occured to me this evening when I was preparing 
the patches. I'll consider it for the final post.

Thanks
 
> 
> >+#define AUTOFS_TYP_INDIRECT     0x0001
> >+#define AUTOFS_TYP_DIRECT       0x0002
> >+#define AUTOFS_TYP_OFFSET       0x0004
> 
> >+	unsigned int type;
> 
> 
> Jan Engelhardt
> -- 
> 

