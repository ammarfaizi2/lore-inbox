Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVHDD5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVHDD5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 23:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVHDD5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 23:57:02 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40700 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261792AbVHDD5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 23:57:00 -0400
Subject: Re: question on memory map of process on i386
From: Steven Rostedt <rostedt@goodmis.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Keith Owens <kaos@ocs.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42F15326.6000402@nortel.com>
References: <42F15326.6000402@nortel.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 23:56:07 -0400
Message-Id: <1123127767.1590.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 17:28 -0600, Christopher Friesen wrote:
> On i386, /proc/<pid>/maps shows the following entry:
> 
> ffffe000-fffff000 ---p 00000000 00:00 0
> 
> This page of memory is way up above TASK_SIZE (which is 0xc0000000), so 
> how is it visible to userspace?
> 
> Just to complicate things,  I seem to find the vma for this page using 
> find_vma_prev().
> 
> Can anyone explain what's going on?
> 

Looking at the code, it seems to be the "gate area". But what this is
used for, I'm not really sure. I did a little searching but found no
good explanations of it. So I added Keith to the CC since most of the
updates to this was submitted by him :-)

-- Steve


