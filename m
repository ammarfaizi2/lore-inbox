Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUBPAHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUBPAHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:07:11 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:44482 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S265271AbUBPAGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:06:46 -0500
Message-ID: <403008C0.1070806@lbl.gov>
Date: Sun, 15 Feb 2004 16:03:12 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix make rpm in 2.6 when using RH9 or Fedora..
References: <402BD507.2040201@lbl.gov> <402EE151.4000807@tmr.com>
In-Reply-To: <402EE151.4000807@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> 
> Why do you want to disable the missing file check? As opposed to 
> providing the file?
> 
> I personally fix ther problem instead of disabling the check, the list 
> can be empty, of course.
> 

There is four options to fix this problem.

1) Change the RH9/Fedora macros.
2) Add a global entry into my .rpmmacros
3) Find and create the missing file (empty, in this case) (ie, do a 'touch /usr/src/linux-2.6.3/debugfiles.list' and it will proceed without making the debugfile RPM.)
4) Disable it in the specfile, since only RH9/Fedora does this, and Mandrake/SuSE probably doesn't.

I'm not going to do #1, and I'm not going to do #2, I'll settle for #3 or #4, but #3 now means another file to ship around or create, even if it's empty.

This simply gets it working again.
thomas
