Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbTH2X2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTH2X2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:28:24 -0400
Received: from TEST.13thfloor.at ([212.16.62.51]:8640 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262079AbTH2X2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:28:19 -0400
Date: Sat, 30 Aug 2003 01:28:18 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Michael Pruznick <michael_pruznick@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: root=nfs no longer works in 2.4.22
Message-ID: <20030829232817.GA14639@DUK2.13thfloor.at>
Mail-Followup-To: Michael Pruznick <michael_pruznick@mvista.com>,
	linux-kernel@vger.kernel.org
References: <3F4FDD44.4151E86C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4FDD44.4151E86C@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 05:09:56PM -0600, Michael Pruznick wrote:
> Was root=nfs removed on purpose or is it an unexpected
> side effect of the "ROOT NFS fixes" patch from late
> July 2003?

not unexpected ...

> I understand this patch from the point of wanting to
> eliminate nfs attempts when nfs is not requested.  That
> is clearly a reasonable thing to do.  However, "root=nfs"
> is a nfs request that has been accepted in the past, I've
> been told, because nfs isn't a real device (but maybe it
> was accepted as bug and this patch fixed it).

simple, there was a discrepancy between the 'device'
table scanned on boot, and the actual device names
root=/dev/nfs is correct, where root=wossname worked
because it wasn't checked against anything ...

root=/dev/nfs will work for you, otherwise it is a
bug, and we'll have to fix it ...

HTH,
Herbert

