Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVJDPmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVJDPmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVJDPmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:42:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23944 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964815AbVJDPmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:42:14 -0400
Date: Tue, 4 Oct 2005 10:42:07 -0500
From: Erik Jacobson <erikj@sgi.com>
To: serue@us.ibm.com
Cc: Erik Jacobson <erikj@sgi.com>, pagg@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Process Notification / pnotify user: Job
Message-ID: <20051004154206.GA28496@sgi.com>
References: <20051003184644.GA19106@sgi.com> <20051003185155.GB19106@sgi.com> <20051003190219.GA20154@sgi.com> <20051004153414.GA9154@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004153414.GA9154@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Should it be possible to compile job as a module, or should
> this not be "tristate"?
> 
> It makes use of send_group_sig_info, which is not EXPORTed.

You are right, the patch is supposed to export that variable as well.
I must have forgot to add it to the file list using quilt before sending
it out, and I tested it as built-in so I didn't catch it.

I'll fix this.  Thank you.

We're only using send_group_sig_info because it does a check for signal
'zero' which means status check.  send_sig_info doesn't do that check any
more.  We could probably just handle this inside job some how and use
send_sig_info instead.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
