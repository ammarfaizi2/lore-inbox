Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWBAO6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWBAO6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWBAO6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:58:18 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13490 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161073AbWBAO6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:58:17 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Edward Shishkin <edward@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 16:57:55 +0200
User-Agent: KMail/1.8.2
Cc: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <43E0A0F9.2090806@namesys.com> <200602011626.17697.vda@ilport.com.ua>
In-Reply-To: <200602011626.17697.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011657.55761.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 16:26, Denis Vlasenko wrote:
> Updated tools to reiserfsprogs-3.6.19, then:
> 
> # reiserfsck -j /dev/sdc3 /dev/sdc3
> reiserfsck 3.6.19 (2003 www.namesys.com)
> 
> *************************************************************
> ** If you are using the latest reiserfsprogs and  it fails **
> ** please  email bug reports to reiserfs-list@namesys.com, **
> ** providing  as  much  information  as  possible --  your **
> ** hardware,  kernel,  patches,  settings,  all reiserfsck **
> ** messages  (including version),  the reiserfsck logfile, **
> ** check  the  syslog file  for  any  related information. **
> ** If you would like advice on using this program, support **
> ** is available  for $25 at  www.namesys.com/support.html. **
> *************************************************************
> 
> Will read-only check consistency of the filesystem on /dev/sdc3
> Will put log info to 'stdout'
> 
> Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes
> ###########
> reiserfsck --check started at Wed Feb  1 16:24:20 2006
> ###########
> Replaying journal..
> No transactions found
> Checking internal tree..finished
> Comparing bitmaps..finished
> Checking Semantic tree:
> finished
> No corruptions found
> There are on the filesystem:
>         Leaves 8075
>         Internal nodes 52
>         Directories 1792
>         Other files 31865
>         Data block pointers 1058363 (0 of them are zero)
>         Safe links 0
> ###########
> reiserfsck finished at Wed Feb  1 16:26:33 2006
> ###########

I hit [reply] too fast.

reiserfsck 3.6.19 reports success now even without -j option,
but still (kernel 2.6.15.1):

# mount /dev/sdc3 /.3
mount: you must specify the filesystem type

How can I fix it?
--
vda
