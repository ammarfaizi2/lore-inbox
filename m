Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270928AbTGVRWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270932AbTGVRWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:22:46 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:48413 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270928AbTGVRWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:22:45 -0400
Date: Tue, 22 Jul 2003 13:37:48 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp64-178.boston.redhat.com
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
cc: vda@port.imtp.ilyichevsk.odessa.ua, <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
In-Reply-To: <3F1CDE99.6000505@gibraltar.at>
Message-ID: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I tell init to re-execute itself (after pivot_root and thus from the new 
> root fs), which causes init to close its old fds and open new ones from 
> the new root fs with. This is necessary because init already runs as pid 
> 1 when I start the root fs switching. Maybe something changed with the 
> kernel process fds from 2.4.21-rc2 to 2.4.21-ac4 ?
> 

yes, see the addition of the unshare_files function in kernel/fork.c

-Jason 

