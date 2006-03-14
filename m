Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752131AbWCNCln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbWCNCln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWCNCln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:41:43 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:33463 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752125AbWCNClm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:41:42 -0500
Subject: Re: [Patch 9/9] Generic netlink interface for delay accounting
From: Matt Helsley <matthltc@us.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1142297791.5858.31.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 18:33:27 -0800
Message-Id: <1142303607.24621.63.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 19:56 -0500, Shailabh Nagar wrote:
<snip>

> Comments addressed (all in response to Jamal)
> 
> - Eliminated TASKSTATS_CMD_LISTEN and TASKSTATS_CMD_IGNORE

The enums for these are still in the patch. See below.

<snip>

> +/*
> + * Commands sent from userspace
> + * Not versioned. New commands should only be inserted at the enum's end
> + */
> +
> +enum {
> +       TASKSTATS_CMD_UNSPEC,           /* Reserved */
> +       TASKSTATS_CMD_NONE,             /* Not a valid cmd to send
> +                                        * Marks data sent on task/tgid exit */
> +       TASKSTATS_CMD_LISTEN,           /* Start listening */
> +       TASKSTATS_CMD_IGNORE,           /* Stop listening */

>From the description I thought you had eliminated these.

> +       TASKSTATS_CMD_PID,              /* Send stats for a pid */
> +       TASKSTATS_CMD_TGID,             /* Send stats for a tgid */
> +};

Jamal, was your Mon, 13 Mar 2006 21:29:09 -0500 reply:
> Note, you are still not following the standard scheme of doing things.
> Example: using command = GET and the message carrying the TGID to note
> which TGID is of interest. Instead you have command = TGID.
> 
> cheers,
> jamal

meant to suggest that TASKSTATS_CMD_(P|TG)ID should be renamed to
TASKSTATS_CMD_GET_(P|TG)ID ? Is that sufficient? Or am I
misunderstanding?

<snip>

Cheers,
	-Matt Helsley

