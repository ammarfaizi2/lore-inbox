Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVHFBa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVHFBa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVHFBa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:30:26 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:21168 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261893AbVHFBaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:30:23 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
X-Message-Flag: Warning: May contain useful information
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	<52u0i6b9an.fsf_-_@cisco.com>
	<86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
	<86802c4405080410236ba59619@mail.gmail.com>
	<86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	<86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	<86802c440508051103500f6942@mail.gmail.com>
	<86802c44050805175757f6ff6a@mail.gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 05 Aug 2005 18:30:07 -0700
In-Reply-To: <86802c44050805175757f6ff6a@mail.gmail.com> (yhlu's message of
 "Fri, 5 Aug 2005 17:57:55 -0700")
Message-ID: <52hde36ee8.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Aug 2005 01:30:19.0365 (UTC) FILETIME=[67F7B950:01C59A26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    yhlu> Roland, what is the -16 mean?

    yhlu> is it /* Attempt to modify a QP/EE which is not in the
    yhlu> presumed state: */ MTHCA_CMD_STAT_BAD_QPEE_STATE = 0x10,

No, -16 is just -EBUSY.  You could put a printk in event_timeout() in
mthca_cmd.c to make sure, but I'm pretty sure that's where it's coming
from.  In other words we issue the CONF_SPECIAL_QP firmware command
and don't ever get a response back from the HCA.

 - R.
