Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWDGCJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWDGCJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 22:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWDGCJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 22:09:49 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:11800 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932280AbWDGCJt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 22:09:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ccgmpqTTAKiprxpr+X7ro1C5jIx7Vb7IXMEVilec+ZlxCYkaoE6uoiBbLQKqyeZJgbAyT5OdEt5sM9wmjhyMxeS18vQPEIYaTwbacgK0Wc44Zae1JTOUeOCChxJ+dbnk7wqzBZElCPjPsYRz2L7MCFhTBkmxSKD3o57y9Ye74xc=
Message-ID: <bda6d13a0604061909u69dd8453me4c9b96cca8d34f5@mail.gmail.com>
Date: Thu, 6 Apr 2006 19:09:48 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: wait4/waitpid/waitid oddness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Albert Cahalan <acahalan@gmail.com> wrote:
> The kernel prohibits:
>
> 1. WNOHANG on waitpid/wait4
> 2. __WALL on waitid
>
> Why? I need both at once.

Why don't you try removing the checks and see if anything breaks. My instinct
says that waitid is less likely to break.

I'm the guy who removed the check in link() about source is a directory, found
out what broke, and am working on a patch to fix all the resulting breakage.
Your task is apt to be a lot simpler.
