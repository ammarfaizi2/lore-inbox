Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVKCOmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVKCOmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVKCOmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:42:52 -0500
Received: from silver.veritas.com ([143.127.12.111]:7518 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751372AbVKCOmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:42:51 -0500
Date: Thu, 3 Nov 2005 14:41:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Rob Landley <rob@landley.net>
cc: "Alexander E. Patrakov" <alexander@linuxfromscratch.org>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs (documentation?) bug
In-Reply-To: <200511021658.57552.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511031431550.23350@goblin.wat.veritas.com>
References: <436847DD.5050504@ums.usu.ru> <4368485C.3050505@linuxfromscratch.org>
 <200511021658.57552.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Nov 2005 14:42:51.0228 (UTC) FILETIME=[DDD9F1C0:01C5E084]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Rob Landley wrote:
> 
> So what's the new way to specify "this tmpfs mount should just be a directory 
> hierarchy with no data blocks" for those of us who _want_ the old behavior?

Sorry about that.  I guess you'll have to do the unaesthetic

mount -t tmpfs -o nr_blocks=1 tmpfs /mountpoint
echo full >/mountpoint/.full

Hugh
