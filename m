Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTEONop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTEONop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:44:45 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:39322 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264016AbTEONoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:44:44 -0400
Message-Id: <200305151355.h4FDtbGi012336@locutus.cmf.nrl.navy.mil>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2 
In-reply-to: Your message of "Thu, 15 May 2003 14:35:15 BST."
             <6445.1053005715@warthog.warthog> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 15 May 2003 09:55:37 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <6445.1053005715@warthog.warthog>,David Howells writes:
>Where's this 1:1 come from? PAGs aren't 1:1 with processes, nor are they 1:1
>with users.
>
>I've tried to implement them as I understand the design information I could
>find (which specified that any process could belong to a single PAG). From the
>comments that have been made, it seems that each user needs some sort of
>fallback token set for any process that doesn't have a PAG.

PAGs shouldnt be 1:1 with processes or users.  They are closer in nature
to process groups.  However,  a process wouldnt loose its PAG affiliation
after calling setsid.  This is the main reason using the process group
isn't sufficient for PAGs.
