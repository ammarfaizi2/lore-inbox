Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUCaV6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUCaVrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:47:00 -0500
Received: from mesa.unizar.es ([155.210.11.66]:53679 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S262612AbUCaVqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:46:02 -0500
In-Reply-To: <1080689525.2557.91.camel@lade.trondhjem.org>
References: <7617358E-82A1-11D8-82F0-000A9585C204@able.es> <1080689525.2557.91.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C9212863-835C-11D8-A4F8-000A9585C204@able.es>
Content-Transfer-Encoding: 7bit
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: NFS sloow on 2.4
Date: Wed, 31 Mar 2004 23:45:54 +0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 mar 2004, at 01:32, Trond Myklebust wrote:

> On Tue, 2004-03-30 at 18:24, J.A. Magallon wrote:
>> mount:
>> 192.168.1.1:/home on /home type nfs
>> (rw,nfsvers=3,tcp,rsize=8192,wsize=8192,noac,addr=192.168.1.1)
>
> Turn off "noac": That forces slooooow synchronous writes as per
> Solaris...
>

Thanks, that made it:

annwn:~> bpsh 6 time -p dd if=/dev/zero of=tst bs=8192 count=8192
8192+0 records in
8192+0 records out
real 2.35
user 0.00
sys 0.33

64Mb in 2.35 secs = about 27Mb/s

Nice...

--
J.A. Magallon <jamagallon()able!es>   \          Software is like sex:
werewolf!able!es                       \    It's better when it's free
MacOS X 10.3.3, Build 7F44, Darwin Kernel Version 7.3.0

