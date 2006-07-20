Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWGTWLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWGTWLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 18:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWGTWLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 18:11:09 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:24208 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1030387AbWGTWLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 18:11:08 -0400
Date: Fri, 21 Jul 2006 00:11:06 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Bill Ryder <bryder@wetafx.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x kernels
Message-ID: <20060720221106.GA5062@janus>
References: <44B32888.6050406@wetafx.co.nz> <20060719080213.GA22925@janus> <44BE936B.3080107@wetafx.co.nz> <20060720093557.GA1796@janus> <44BFEA4C.6050602@wetafx.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BFEA4C.6050602@wetafx.co.nz>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 08:40:44AM +1200, Bill Ryder wrote:
[...]
> This phrase is worrying:
> 
> When there is no group id information passed downwards
> then it reverts to old behavior too.
> 
> Why would no group id information be passed?

There are a few NFS operations (or related ones such as
for file locking) which do not need that information IIRC.
"old behavior" means doing what it does _today_.


> For someone of my level of knowledge of the kernel the README does not
> convince me it will work in all situations.

NFS with AUTH_UNIX authentication cannot possibly get worse than it is
today with respect to processes in more than 16 groups. And the patch
is effectively disabled for processes in <=16 groups so I wouldn't
worry.

Anyway, a revised patch from you which no longer sorts the first 16
groups for compatibility reasons is probably easier to get merged.

-- 
Frank
