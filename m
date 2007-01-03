Return-Path: <linux-kernel-owner+w=401wt.eu-S932126AbXACVJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbXACVJp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbXACVJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:09:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33076 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbXACVJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:09:43 -0500
In-Reply-To: <20070103185815.GA2182@janus>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Subject: Re: Finding hardlinks
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF9726A29A.AA3902E2-ON85257258.0072E396-88257258.00740500@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Wed, 3 Jan 2007 13:09:41 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V80_M3_10312006|October 31, 2006) at
 01/03/2007 16:09:43,
	Serialize complete at 01/03/2007 16:09:43
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On any decent filesystem st_ino should uniquely identify an object and
>reliably provide hardlink information. The UNIX world has relied upon 
this
>for decades. A filesystem with st_ino collisions without being hardlinked
>(or the other way around) needs a fix.

But for at least the last of those decades, filesystems that could not do 
that were not uncommon.  They had to present 32 bit inode numbers and 
either allowed more than 4G files or just didn't have the means of 
assigning inode numbers with the proper uniqueness to files.  And the sky 
did not fall.  I don't have an explanation why, but it makes it look to me 
like there are worse things than not having total one-one correspondence 
between inode numbers and files.  Having a stat or mount fail because 
inodes are too big, having fewer than 4G files, and waiting for the 
filesystem to generate a suitable inode number might fall in that 
category.

I fully agree that much effort should be put into making inode numbers 
work the way POSIX demands, but I also know that that sometimes requires 
more than just writing some code.

--
Bryan Henderson                               San Jose California
IBM Almaden Research Center                   Filesystems

