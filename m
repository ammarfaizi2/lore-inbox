Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753885AbWKFWb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbWKFWb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753883AbWKFWb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:31:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753880AbWKFWb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:31:56 -0500
Message-ID: <454FB7DA.5070305@redhat.com>
Date: Mon, 06 Nov 2006 16:31:54 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] - catch blocks beyond pagecache limit in __getblk_slow
References: <454FB710.2030108@redhat.com>
In-Reply-To: <454FB710.2030108@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=206328
> 
> has a nice analysis of what can go wrong when we try to read blocks which
> are at extremely high offsets, when our sector_t is 64 bits but our pgoff_t
> is only 32.  The cases in question that I've seen are the result of filesystem
> corruption.

Urk, scratch that I see a fix is already in.

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e5657933863f43cc6bb76a54d659303dafaa9e58

-Eric
