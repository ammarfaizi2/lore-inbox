Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270248AbTHGQkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTHGQkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:40:17 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15687 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270384AbTHGQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:38:32 -0400
Date: Thu, 7 Aug 2003 12:41:08 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp64-178.boston.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
In-Reply-To: <1060271448.3123.75.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308071223370.894-100000@dhcp64-178.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 Aug 2003, Alan Cox wrote:

> On Iau, 2003-08-07 at 16:26, Jason Baron wrote:
> > it clearly makes a difference.
> > 
> > the unshare_files change causes init to no longer share the same fd table
> > with the other kernel threads. thus, when init closes or opens fds it does
> 
> Ah yes.. because of do_basic_setup. Having /sbin/init sharing with
> kernel threads doesn't actually strike me as too clever anyway although
> none of them should be using fd stuff.
> 
> In which case I guess we should call unshare_files directly before we
> open /dev/console in init/main.c.
> 

ok, but what if we re-exec init a couple of times? 

