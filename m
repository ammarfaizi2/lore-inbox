Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCLKJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUCLKJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:09:18 -0500
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:32909 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261186AbUCLKJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:09:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Anders K. Pedersen" <akp@cohaesio.com>
Subject: Re: 2.6.3 userspace freeze
Date: Fri, 12 Mar 2004 21:08:41 +1100
User-Agent: KMail/1.6.1
Cc: "Jan Kara" <jack@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <222BE5975A4813449559163F8F8CF503458441@cohsrv1.cohaesio.com>
In-Reply-To: <222BE5975A4813449559163F8F8CF503458441@cohsrv1.cohaesio.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403122108.41746.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004 07:47 pm, Anders K. Pedersen wrote:
> To night I reproduced this issue with Linux 2.6.4 final - I've attached
> the dmesg and .config for this kernel.

> 23536 root      34  19  1664  720  1368 D N   6.0  0.0   0:00   1
> updatedb

Each log you've shown so far shows you getting updatedb stuck in D which 
appears to be the common link. It could be your updatedb is busy scanning 
directories it probably shouldn't.
Check your updatedb.conf (usually in /etc) and see that you have at least 
these entries in PRUNEFS

PRUNEFS="nfs,smbfs,ncpfs,proc,devpts,supermount,vfat,iso9660,udf,usbdevfs,devfs,usbfs,sysfs"

Con
