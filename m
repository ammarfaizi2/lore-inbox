Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271028AbTG1UTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbTG1UTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:19:17 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:56203 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S270880AbTG1UTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:19:12 -0400
Date: Mon, 28 Jul 2003 16:19:04 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030728201903.GA2978@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307281555400.27569@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0307281555400.27569@chaos>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-7.9, required 5,
	BAYES_10, IN_REP_TO, REFERENCES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 28 jui 2003 16:00:03 GMT, Richard B. Johnson a tapoté sur son clavier :
> I have experimentally determined that I can turn off
> the automatic screen blanking with the following escape
> sequence.
> 
> const char blk[]={27, '[', '9', ';', '0', ']', 0};
> main()
> {
>     printf(blk);
> }

Yes, this is what setterm -blank 0 does. See setterm_command() in
drivers/char/console.c(2.4) or vt.c(2.6)

> I need to know what the appropriate ioctl() is to do this
> directly without using escape sequences.

It's not possible even with current 2.6.0-test2 but could be added to
tioclinux in a few lines.

Regards,
Samuel Thibault
