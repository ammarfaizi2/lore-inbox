Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWBAPAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWBAPAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBAPAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:00:10 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10380 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161075AbWBAPAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:00:08 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: vitaly@namesys.com
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 16:59:52 +0200
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com, Chris Mason <mason@suse.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <200601281613.16199.vda@ilport.com.ua> <200602011445.05785.vitaly@namesys.com> <200602011625.25572.vda@ilport.com.ua>
In-Reply-To: <200602011625.25572.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602011659.52572.vda@ilport.com.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 16:25, Denis Vlasenko wrote:
> On Wednesday 01 February 2006 13:45, Vitaly Fertman wrote:
> > On Wednesday 01 February 2006 13:15, Denis Vlasenko wrote:
> > > 
> > > # reiserfstune -s 1024 /dev/sdc3
> > > # mount /dev/sdc3 /.3 -o noatime
> > > mount: you must specify the filesystem type
> > > 
> > > # dmesg | tail -4
> > > br: topology change detected, propagating
> > > br: port 1(ifi) entering forwarding state
> > > FAT: bogus number of reserved sectors
> > > VFS: Can't find a valid FAT filesystem on dev sdc3.
> > > 
> > > # reiserfsck /dev/sdc3
> > > reiserfsck 3.6.11 (2003 www.namesys.com)
> > 
> > your reiserfsprogs are old. which kernel are you using?
> 
> # uname -a
> Linux pegasus 2.6.12.3-2 #1 SMP Thu Sep 15 11:04:37 EEST 2005 i686 unknown unknown GNU/Linux

I actually _looked at_ the uname output :) I am running wrong kernel!
Rebooted into 2.6.15.1. Mount still failing.
--
vda
