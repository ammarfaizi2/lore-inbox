Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVDFWTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVDFWTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVDFWTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:19:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:55477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262335AbVDFWTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:19:39 -0400
Date: Wed, 6 Apr 2005 15:19:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050406151943.37ff237b.akpm@osdl.org>
In-Reply-To: <16979.16146.433143.743902@cse.unsw.edu.au>
References: <20050405000524.592fc125.akpm@osdl.org>
	<16979.16146.433143.743902@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> On Tuesday April 5, akpm@osdl.org wrote:
> > 
> > - Nobody said anything about the PM resume and DRI behaviour in
> >   2.6.12-rc1-mm4.  So it's all perfect now?
> 
> Well, Seeing you asked...
> 
> PM resume certainly seems to be improving.
> My main problem in rc1-mm3 is with PCMCIA.
> If I stop cardmgr before suspend-to-RAM, and then try to
> restart it after resume, I cannot.  Some message about the socket
> being in use, and am I sure there is no other cardmgr running (there
> isn't). 

I don't know whether the PCMCIA problem is due to PCMCIA changes or not. 
The only thing I see having changed between 2.6.12-rc1-mm3 and
2.6.12-rc2-mm1 is the addition of pcmcia-resource-handling-fixes.patch. 
Would you have time to revert that, retest?  

There have been a few problem in the area of device management in
bk-driver-core.  I think we're getting that settled down now.

