Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTKJSso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbTKJSso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:48:44 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:44541 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264063AbTKJSsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:48:42 -0500
Date: Mon, 10 Nov 2003 11:46:11 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <andrea@suse.de>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110114611.M10197@schatzie.adilger.int>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <andrea@suse.de>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>; from davidel@xmailserver.org on Mon, Nov 10, 2003 at 10:27:33AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2003  10:27 -0800, Davide Libenzi wrote:
> So the update of the rsync repo should do something like:
> 
> update file1
> update repo
> update file2
> 
> Isn't it? I do not understand how this guarantee coherency:
> 
> Kernel.org             Me
>                        get file1 (old value)
> update file1           get repo-file1 (old value)
> update repo-file1
> ...
> update repo-fileJ
> ...                    get repo-fileJ (new value)
> update repo-fileN      get file2 (old value)
> update file2

The source (kernel.org or bkbits) would update file2 first.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

