Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVIFR5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVIFR5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVIFR5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:57:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22922 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750741AbVIFR5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:57:38 -0400
Date: Tue, 6 Sep 2005 18:57:37 +0100
From: viro@ZenIV.linux.org.uk
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: can kill X server but readlink of /proc/<pid>/exe et. al. says EACCES. feature?
Message-ID: <20050906175737.GY5155@ZenIV.linux.org.uk>
References: <20050906175349.GA390@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906175349.GA390@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 07:53:49PM +0200, Frank van Maarseveen wrote:
> While I have access to /proc/<pid>, readlink fails with EACCES on
> 
> 	/proc/<pid>/exe
> 	/proc/<pid>/cwd
> 	/proc/<pid>/root
> 
> even when I own <pid> though it runs with a different effective/saved/fs
> uid such as the X server. This is a bit uncomfortable and doesn't
> seem right.
> 
> Or is this to make /proc mounting inside a chroot jail safe?

suid-root task does chdir() to place you shouldn't be able to access.
You do cd /proc/<pid>/cwd and get there anyway.  Bad Things Happen...
