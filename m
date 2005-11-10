Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVKJAlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVKJAlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVKJAlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:41:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751130AbVKJAlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:41:07 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix ptrace self-attach rule
X-Fcc: ~/Mail/linus
X-Zippy-Says: I want you to MEMORIZE the collected poems of EDNA ST VINCENT
   MILLAY..  BACKWARDS!!
Message-Id: <20051110004100.BDE06180A3A@magilla.sf.frob.com>
Date: Wed,  9 Nov 2005 16:41:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this does affect some real programs out there.  I'm not advocating
using ptrace on other threads in your thread group, but people have been
doing it.  We know because that's how some of the pathological cases have
come up that we've had to do fixes for.  Ruling it out may make these
people unhappy, though I hope that we will have better ways for them to do
whatever it is they really need.  Just FYI.


Thanks,
Roland


diff-tree 28d838cc4dfea980cb6eda0a7409cbf91889ca74 (from ac111bfaa6b0b3c0edc63c27bd9617d6b08851ff)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Nov 9 11:33:07 2005 -0800

    Fix ptrace self-attach rule
    
    Before we did CLONE_THREAD, the way to check whether we were attaching
    to ourselves was to just check "current == task", but with CLONE_THREAD
    we should check that the thread group ID matches instead.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

