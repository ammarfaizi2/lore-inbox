Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSHJJfF>; Sat, 10 Aug 2002 05:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSHJJfE>; Sat, 10 Aug 2002 05:35:04 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:8910
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S316728AbSHJJfE>; Sat, 10 Aug 2002 05:35:04 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200208100938.g7A9cmH06158@www.hockin.org>
Subject: get rid of NGROUPS limit - prelim patch
To: linux-kernel@vger.kernel.org
Date: Sat, 10 Aug 2002 02:38:48 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all, as promised a few weeks back, I am cleaning up our patch to get
rid of the NGROUPS hard limit.

Here is the URL to the preliminary patch.  THIS IS NOT COMPLETE.  I wanted
to post it here so I could get any feedback on it.  This should work fine
on i386.  Other arch's I am shooting in the dark (there are a couple FIXME
comments - can you answer them?).  Other archs are not complete in this
patch.

http://www.hockin.org/~thockin/linux-kernel/ngroups-2.4-prelim.diff

Summary:
* add lib/bsearch.c
* add lib/qsort.c
* add include/linux/groups.h  (is this better in an existing header?)
* add ngroups_max - sysctl controllable upper bound
* change current->groups[] to refcounted dynamic memory

Comments please?  If I don't have any major complaints, I'll push on.  I
really would like some feedback on the other archs, if possible.

Thanks

Tim

