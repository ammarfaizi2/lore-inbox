Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbUKEEjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUKEEjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUKEEjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:39:15 -0500
Received: from [12.177.129.25] ([12.177.129.25]:65219 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262590AbUKEEjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:39:13 -0500
Message-Id: <200411050548.iA55m4DZ007773@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Blaisorblade <blaisorblade_spam@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, cw@f00f.org
Subject: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler 
In-Reply-To: Your message of "Thu, 04 Nov 2004 05:11:44 +0100."
             <200411040511.54892.blaisorblade_spam@yahoo.it> 
References: <20041103231735.8C1E955C79@zion.localdomain> <200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>  <200411040511.54892.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Nov 2004 00:48:04 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it said:
> I had a doubt on this, but I was not getting much feedback from you...
Yeah, sorry.

> Also, if you reject this, I'd require a comment-only patch for it: "as
> soon as I remember why" makes me think back to my yesterday's class,
> when  the teacher said "put comments in your code or you'll soon
> forget what it  does!" 8-O (yes, 1st year University student :-( ). 

The thing is, you often don't realize what's going to be mysterious until it 
actually is, and then it's too late for the comment :-)

In this case, it wants to be bounced out of sigprocmask when a SIGWINCH 
arrives.  In order to do so, it must have a handler registered, even if
it does nothing.

				Jeff

