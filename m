Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTKMU1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTKMU1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:27:16 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:37879 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264411AbTKMU1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:27:11 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Martin.Knoblauch@mscsoftware.com, root@chaos.analogic.com
Subject: Re: nfs_statfs: statfs error = 116
Date: Thu, 13 Nov 2003 14:26:25 -0600
X-Mailer: KMail [version 1.2]
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <OF8497F0B5.C94E6443-ONC1256DDD.0051048E-C1256DDD.0051C1A9@mscsoftware.com>
In-Reply-To: <OF8497F0B5.C94E6443-ONC1256DDD.0051048E-C1256DDD.0051C1A9@mscsoftware.com>
MIME-Version: 1.0
Message-Id: <03111314262500.15082@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 November 2003 08:52, Martin.Knoblauch@mscsoftware.com wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> wrote on 11/13/2003 03:39:53
>
> PM:
> > On Thu, 13 Nov 2003, martin.knoblauch  wrote:
[snip]
> > ESTALE happens when a mounted file-system is on a server that
> > went down or re-booted. The file-handles are then "stale".
>
>  I am "alomost" sure that there were no reboot or failover events at the
> time of most of the stale messages. But I'm not going to lay my hand on the
> book for that.

ESTALE should occur whenever the client looses connection to the server,
or thinks it has lost connection. It isn't directly related to the server
other than the fact that a server reboot will also cause it to happen.

This should be a transient failure that recovers when communication verified
from some of the timeouts/retries associated with NFS.

At worst, it can require a remount of the NFS volumn.
