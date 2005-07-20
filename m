Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVGTNfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVGTNfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGTNfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:35:11 -0400
Received: from news.cistron.nl ([62.216.30.38]:37844 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261217AbVGTNfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:35:09 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: a 15 GB file on tmpfs
Date: Wed, 20 Jul 2005 13:35:07 +0000 (UTC)
Organization: Cistron
Message-ID: <dbljub$mgm$1@news.cistron.nl>
References: <200507201416.36155.naber@inl.nl> <20050720132006.GI7050@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1121866507 23062 194.109.0.112 (20 Jul 2005 13:35:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050720132006.GI7050@harddisk-recovery.com>,
Erik Mouw  <erik@harddisk-recovery.com> wrote:
>On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
>> I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
>> this because I need to have this data accessible with a very low seek time.
>
>That should be no problem on a 64 bit architecture.
>
>AFAIK you can't use a 15 GB tmpfs on i386 because large memory support
>is basically a hack to support multiple 4GB memory spaces (some VM guru
>correct me if I'm wrong).

I'm no VM guru but I have a 32 bit machine here with 8 GB of
memory and 8 GB of swap:

# mount -t tmpfs -o size=$((12*1024*1024*1024)) tmpfs /mnt
# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1             19228276   1200132  17051396   7% /
tmpfs                 12582912         0  12582912   0% /mnt

There you go, a 12 GB tmpfs. I haven't tried to create a 12 GB
file on it, though, since this is a production machine and it
needs the memory ..

So yes that appears to work just fine.

Mike.

