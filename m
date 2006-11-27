Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758542AbWK0UWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542AbWK0UWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758559AbWK0UWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:22:12 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:61605 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1758542AbWK0UWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:22:12 -0500
Date: Mon, 27 Nov 2006 21:22:11 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix the binary ipc and uts namespace sysctls.
Message-ID: <20061127202211.GB26108@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Containers <containers@lists.osdl.org>,
	linux-kernel@vger.kernel.org
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 09:59:26PM -0700, Eric W. Biederman wrote:
> 
> The binary interface to the namespace sysctls was never implemented
> resulting in some really weird things if you attempted to use
> sys_sysctl to read your hostname for example.
> 
> This patch series simples the code a little and implements the binary
> sysctl interface.
> 
> In testing this patch series I discovered that our 32bit compatibility
> for the binary  sysctl interface is imperfect.  In particular
> KERN_SHMMAX and KERN_SMMALL are size_t sized quantities and are
> returned as 8 bytes on to 32bit binaries using a x86_64 kernel.  
> However this has existing for a long time so it is not a new
> regression with the namespace work.
> 
> Gads the whole sysctl thing needs work before it stops being easy
> to shoot yourself in the foot.
> 
> Looking forward a little bit we need a better way to handle sysctls
> and namespaces as our current technique will not work for the network
> namespace.  I think something based on the current overlapping sysctl
> trees will work but the proc side needs to be redone before we can
> use it.

the linux banner needs some attention too, when I get
around, I'll send a patch for that ...

best,
Herbert

> Eric
> 
> 
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers
