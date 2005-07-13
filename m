Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVGMBEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVGMBEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVGMBEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:30181 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262589AbVGMBDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:03:13 -0400
From: Chris Mason <mason@suse.com>
To: "Rob Mueller" <robm@fastmail.fm>
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Tue, 12 Jul 2005 21:03:09 -0400
User-Agent: KMail/1.8
Cc: akpm@osdl.org, "Lars Roland" <lroland@gmail.com>,
       "Bron Gondwana" <brong@fastmail.fm>, linux-kernel@vger.kernel.org,
       "Vladimir Saveliev" <vs@namesys.com>,
       "Jeremy Howard" <jhoward@fastmail.fm>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <200507122042.11397.mason@suse.com> <03b601c58744$ee69e390$7c00a8c0@ROBMHP>
In-Reply-To: <03b601c58744$ee69e390$7c00a8c0@ROBMHP>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507122103.10159.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 20:50, Rob Mueller wrote:

>
> Are you saying that if you mount with noatime *and* use your new patch it
> will fix the problem?
>
> What about the 2 threads linked to. Did those end up getting anywhere?

Sorry for the confusion, you're hitting the other mmap_sem -> transaction lock 
problem.  This one should be solvable with an iget so we make sure not to do 
the final unlink until after the mmap sem is dropped.

Lets see what I can do...

-chris
