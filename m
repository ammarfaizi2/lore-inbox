Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTEUQnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTEUQnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:43:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:10490 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262145AbTEUQnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:43:40 -0400
Date: Wed, 21 May 2003 09:59:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: bzzz@tmi.comex.ru, sct@redhat.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
Message-Id: <20030521095921.4f457002.akpm@digeo.com>
In-Reply-To: <87smr8c9le.fsf@gw.home.net>
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net>
	<20030521093848.59ada625.akpm@digeo.com>
	<87smr8c9le.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 16:56:42.0138 (UTC) FILETIME=[F41BCFA0:01C31FB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> yes, we may protect it by such lock, but this lock have to be held all time
>  ext3_new_block() uses some b_committed_data because last one may be freed
>  during current ext3_new_block(). I don't think it's good.

Take a closer look - I don't think it'll be too messy, and certainly the
hold times will not be a problem.

