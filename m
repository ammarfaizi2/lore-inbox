Return-Path: <linux-kernel-owner+w=401wt.eu-S1751919AbXAREVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbXAREVc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 23:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbXAREVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 23:21:32 -0500
Received: from 1wt.eu ([62.212.114.60]:1989 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbXAREVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 23:21:32 -0500
Date: Thu, 18 Jan 2007 05:21:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Santiago Garcia Mantinan <manty@debian.org>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org, dannf@dannf.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Message-ID: <20070118042116.GA11914@1wt.eu>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <4pctq2tqjnoap3khma0496h2fhfpg1rs75@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4pctq2tqjnoap3khma0496h2fhfpg1rs75@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant !

On Thu, Jan 18, 2007 at 11:09:57AM +1100, Grant Coady wrote:
(...)
> > 	} else {
> >-		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> >-						S_IROTH | S_IXOTH | S_IFREG;
> >-		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> >-						S_IROTH | S_IXOTH | S_IFDIR;
> >+		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> >+				S_IROTH | S_IXOTH | S_IFREG | S_IFLNK;
> >+		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> >+				S_IROTH | S_IXOTH | S_IFDIR;
> > 		if (parse_options(mnt, raw_data))
> > 			goto out_bad_option;
> 
> I'm comparing 2.4.33.3 with 2.4.34, with 2.4.34 and above patch symlinks 
> to directories seen as target, nor can they be created (Operation not 
> permitted...)

Thanks very much Grant for the test. Could you try a symlink to a file ?
And while we're at it, would you like to try to add "|S_IFLNK" to
mnt->dir_mode ? If my suggestion was stupid, at least let's test it to
full extent ;-)

I had another idea looking at the code but since I really don't know it,
I would not like to propose random changes till this magically works. I'd
wait for Dann who understood the code.

Best regards,
Willy

