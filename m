Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWECSBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWECSBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWECSBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:01:16 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:54276 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751054AbWECSBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:01:16 -0400
Date: Wed, 3 May 2006 20:01:12 +0200
From: bjdouma <bjdouma@xs4all.nl>
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem while applying patch to 2.6.9 kernel
Message-ID: <20060503180112.GA23530@skyscraper.unix9.prv>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAwZsyZCSXbUSO0mznjdzGqgEAAAAA@spsoftindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAwZsyZCSXbUSO0mznjdzGqgEAAAAA@spsoftindia.com>
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 05:32:02PM +0530, Yogesh Pahilwan wrote:
> I am facing some problem while applying patch to the 2.6.9 kernel.
> 
> I have done following to apply the patch:
> 
> # patch -p1 < ../../Patches/patch-ext3
> 
> But getting following things:
> 
> missing header for unified diff at line 3 of patch
> (Stripping trailing CRs from patch.)
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |#--- ../A_CLEAN_FILE_SYSTEM/jbd/commit.c       2006-02-25 11:43:19.000000000 -0600
> |#+++ commit.c  2006-03-29 20:53:29.000000000 -0600
> --------------------------
> File to patch:
> 
> Can anyone suggest what I am doing wrong while applying this patch or if the
> command is correct then why patch is giving the above errors.

You gotta lose the hash-mark at beginning-of-line of lines 1 and 2
(moise from some cut-n-paste operation?).  Then look at the second
line to see how many slashes you gotta skip (with -p -- looks like
it's -p0 here).

bjd
