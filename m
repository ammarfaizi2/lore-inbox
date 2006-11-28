Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935199AbWK1OKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935199AbWK1OKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935138AbWK1OKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:10:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23959 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934629AbWK1OKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:10:00 -0500
Message-ID: <456C432E.2050601@redhat.com>
Date: Tue, 28 Nov 2006 08:09:50 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@redhat.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, rtc@gmx.de
Subject: Re: [PATCH/RFC] pass dio_complete proper offset from finished_one_bio
References: <45691753.60500@redhat.com>
In-Reply-To: <45691753.60500@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> We saw problems w/ xfs doing AIO+DIO into a sparse file.
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=217098
> 
> It seemed that xfs was doing "extent conversion" at the wrong offsets, so
> written regions came up as unwritten (zeros) and stale data was exposed
> in the region after the write.  Thanks to Peter Backes for the very
> nice testcase.
> 
> This also broke xen with blktap over xfs.

Hrmph.  Zach's changes in -mm magically made this go away... I was about 
to submit a proper patch against -mm but it seem to be not needed.

So, now digging around to see why that is, and what exactly "fixed" things.

-Eric

