Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVJIIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVJIIuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVJIIuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 04:50:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932248AbVJIIuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 04:50:54 -0400
Date: Sun, 9 Oct 2005 01:50:45 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <joel.becker@oracle.com>
Cc: wim.coekaerts@oracle.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: hangcheck-timer parameters
Message-Id: <20051009015045.75a2d4cf.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you mind explaining me what this code in 2.6.14-rc3 is supposed
to mean:

drivers/char/hangcheck-timer.c: ---------------------------

/* options - modular */
module_param(hangcheck_tick, int, 0);

/* options - nonmodular */
#ifndef MODULE

static int __init hangcheck_parse_tick(char *str)
{
	int par;
	if (get_option(&str,&par))
		hangcheck_tick = par;
	return 1;
}

__setup("hcheck_tick", hangcheck_parse_tick);
#endif /* not MODULE */
------------------------------------------------------------

Was anything wrong with using hangcheck-timer.hangcheck_tick=1000 ?
Too long to type into grub.conf?

-- Pete
