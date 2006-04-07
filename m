Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWDGGkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWDGGkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDGGkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:40:04 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:46007 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbWDGGkC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:40:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DzOmmx4AWUwFDcqJw25h3A5ElOsx70vDHR4Z8e+GENMWRZBxy1+EdwrkZQhCy+SdSlb+GCwGn1kNbZO6Fv7bXJCyCa7ApxK9jO/ZLc11zU7di7rsaNBumXEmmLA9zS6a/6uGarOW93aepoEfvd88yF5ahhejRKL1VeHmpt5pYqQ=
Message-ID: <bda6d13a0604062340p5f5ff496u20c7f6135284b43f@mail.gmail.com>
Date: Thu, 6 Apr 2006 23:40:02 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: wait4/waitpid/waitid oddness
In-Reply-To: <217AB2B7-BD72-49BE-AB02-AA952728073B@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
	 <bda6d13a0604061909u69dd8453me4c9b96cca8d34f5@mail.gmail.com>
	 <217AB2B7-BD72-49BE-AB02-AA952728073B@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Apr 6, 2006, at 22:09:48, Joshua Hudson wrote:
> > I'm the guy who removed the check in link() about source is a
> > directory, found out what broke, and am working on a patch to fix
> > all the resulting breakage.  Your task is apt to be a lot simpler.
>
> I seem to recall the reason why hardlinking directories was
> prohibited had something more to do with some unfixable races and
> deadlocks in the kernel; not to mention creating self-referential
> directory trees that are never freed and chew up disk space.

You recall correctly. I have fixed the self-referrential problem, and I
am testing a fix for the races and deadlocks. Desk proof is not good
enough for me.
