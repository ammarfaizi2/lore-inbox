Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUHCOv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUHCOv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUHCOv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:51:26 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:59870 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S266511AbUHCOvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:51:18 -0400
X-Sender-Authentication: net64
Date: Tue, 3 Aug 2004 16:51:16 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
Subject: Re: How to increase max number of groups per uid ?
Message-Id: <20040803165116.7b1531b5.skraw@ithnet.com>
In-Reply-To: <20040729163407.02bb2dd6.akpm@osdl.org>
References: <20040729193106.43d4c515.skraw@ithnet.com>
	<20040729163407.02bb2dd6.akpm@osdl.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 16:34:07 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> >
> > is there a simple way in either 2.4 or 2.6 to get a lot more than 32 groups
> > per uid?
> 
> 2.6 kernels support up to 65536 groups per user.

Hello Andrew,

in the meantime - after some testing - I found out the problem lies around nfs.
I cannot seem to change to directories (placed on nfs-volumes) whose
group-member I am.
Is this a known problem? Can I do something about it?

The situation is:

nfs-server 2.4.24
nfs-client 2.6.7

Client knows about 1000 groups and quite a lot users.
Mounting some directories from the nfs-server and checking out rights we found
that users belonging to a group owning a directory cannot access it. If the
exact same tree is located on the clients' local fs everything is fine.

Regards,
Stephan
