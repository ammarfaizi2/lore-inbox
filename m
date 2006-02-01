Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWBALuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWBALuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWBALuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:50:04 -0500
Received: from relay.wplus.net ([195.131.52.142]:39201 "EHLO relay.wplus.net")
	by vger.kernel.org with ESMTP id S1750781AbWBALuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:50:03 -0500
From: Vitaly Fertman <vitaly@namesys.com>
Reply-To: vitaly@namesys.com
To: reiserfs-dev@namesys.com
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 14:45:05 +0300
User-Agent: KMail/1.7.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, Chris Mason <mason@suse.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <200601281613.16199.vda@ilport.com.ua> <200602010942.36134.vda@ilport.com.ua> <200602011215.54637.vda@ilport.com.ua>
In-Reply-To: <200602011215.54637.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200602011445.05785.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 13:15, Denis Vlasenko wrote:
> 
> # reiserfstune -s 1024 /dev/sdc3
> # mount /dev/sdc3 /.3 -o noatime
> mount: you must specify the filesystem type
> 
> # dmesg | tail -4
> br: topology change detected, propagating
> br: port 1(ifi) entering forwarding state
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev sdc3.
> 
> # reiserfsck /dev/sdc3
> reiserfsck 3.6.11 (2003 www.namesys.com)

your reiserfsprogs are old. which kernel are you using?

as I can see 3.6.11 had that problem indeed, however I have no 
problem with progs 3.6.19 and kernel 2.6.9 even after shrinking 
the journal with tune 3.6.11. 

-- 
Vitaly
