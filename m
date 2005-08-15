Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVHOFO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVHOFO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 01:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVHOFO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 01:14:26 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:650 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751060AbVHOFOZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 01:14:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=adHQxqwoNWP1r9HunxiRl7PHsIOwvhpRNkrky+7wSFeg5lqI7+ma7AsVL/uHkATOT/dJrmHaGZjbnMsAvtgyWZowQMlbZtI6WKQlp4cZxQsh43363OpMPupghNet1/vuJcvJAucIU3C0EsZAsMiC1DLiTaalbS1NPvzk7cdubT8=
Message-ID: <2cd57c9005081422143b0f2717@mail.gmail.com>
Date: Mon, 15 Aug 2005 13:14:22 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Mike Waychison <mikew@google.com>
Subject: Re: [patch] unexport __mntput()
Cc: coywolf@sosdg.org, akpm@osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <430014EA.4030404@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050815015357.GA16778@everest.sosdg.org>
	 <430014EA.4030404@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Mike Waychison <mikew@google.com> wrote:
> Coywolf Qi Hunt wrote:
> > Hello,
> >
> > Unexport __mntput() was talked about two months ago. http://lkml.org/lkml/2005/6/9/69
> > Modules should not call __mntput() directly. If autofs or nfsd does that, it's
> >  being wrong.
> 
> I think you missed the point in the last discussion.  __mntput is called

Yes, indeed.

> from mntput(), which autofs and nfsd call.  Their use is correct given
> what they do:
> 
> Autofs 3 and 4 use it for walking the vfsmount tree and determining
> if/when a mountpoint is ready to expire.
> 
> Nfsd uses it to serve up nfs exports that don't cross mountpoints (or
> do, if "crossmnt" is specified in /etc/exports.

And more than above, there's more stuff depend on it, af_unix, ipc
message queues, etc.

Thanks for your help.
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
