Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTFEBi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFEBi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:38:58 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46473 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263638AbTFEBi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:38:57 -0400
Date: Wed, 4 Jun 2003 18:52:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: file write performance drop between 2.5.60 and 2.5.70
Message-Id: <20030604185228.5cfc6b02.akpm@digeo.com>
In-Reply-To: <200306042017.53435.vs@namesys.com>
References: <200306042017.53435.vs@namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 01:52:28.0052 (UTC) FILETIME=[1E598540:01C32B05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev <vs@namesys.com> wrote:
>
> Hi
> 
> It looks like file write performance dropped somewhere between 2.5.60 and 
> 2.5.70.
> Doing
> time dd if=/dev/zero of=file bs=4096 count=60000
> 
> on a box with Xeon(TM) CPU 2.40GHz and 1gb of RAM
> I get for ext2
> 2.5.60: 	real	1.42 sys 0.77
> 2.5.70: 	real 1.73 sys 1.23
> for reiserfs
> 2.5.60: 	real 1.62 sys 1.56
> 2.5.70: 	real 1.90 sys 1.86
> 
> Any ideas of what could cause this drop?
> 

hm, 2.5.60 was a long time ago.  The best way to tell would be comparative
oprofiling.

