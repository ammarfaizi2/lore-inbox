Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTKJSh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTKJSh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:37:56 -0500
Received: from JJ-POSTDOC.MIT.EDU ([18.19.0.210]:53150 "EHLO marbles.mit.edu")
	by vger.kernel.org with ESMTP id S264027AbTKJShx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:37:53 -0500
Date: Mon, 10 Nov 2003 13:37:49 -0500
From: David Roundy <droundy@abridgegame.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110183749.GB15667@jdj5.mit.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
X-Uptime: 13:29:16 up 60 days, 22:13, 29 users,  load average: 8.28, 3.73, 1.57
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 10:27:33AM -0800, Davide Libenzi wrote:
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

The kernel.org side goes

update file2
update repo
update file1
-- 
David Roundy
http://civet.berkeley.edu/droundy/
