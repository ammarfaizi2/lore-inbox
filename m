Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVAFF07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVAFF07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVAFF06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:26:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:17065 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262733AbVAFF0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:26:35 -0500
Date: Wed, 5 Jan 2005 21:26:29 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       narahimi@us.ibm.com
Subject: Re: [PATCH] Enhanced Trusted Path Execution (TPE) Linux Security Module
Message-ID: <20050105212629.K469@build.pdx.osdl.net>
References: <1104979908.8060.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1104979908.8060.34.camel@localhost.localdomain>; from lorenzo@gnu.org on Thu, Jan 06, 2005 at 03:51:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Hernández García-Hierro (lorenzo@gnu.org) wrote:
> This patch adds support for an enhanced Trusted Path Execution (TPE)
> subsystem relying in the Linux Security Modules framework.
> It's a rewrite of the IBM's TPE LSM module by Niki A. Rahimi, which
> adds a couple of improvements and feature enhancements.

Thanks for taking interest and working on this.

> The most notable of them are support for per-gid basis access control
> lists in runtime and kernel-configuration time (adds support for trusted
> and untrusted user groups), procfs interface for statistics and runtime
> information and debugging capabilities (for limiting the garbage
> messages).

How does per-gid help in this case (esp. the desktop scenario you
mentioned)?  And the /proc/tpe file might as well go under sysfs with
the rest of the other entries instead of cluttering /proc.

> The reasons that give sense for including this, are that standard
> Vanilla kernels have SELinux and LSM (SELinux already supports TPE
> functionalities), but SELinux has less possibilities of being used by
> those desktop or just not experienced users who are not already using
> their distribution-specific SELinux implementation, even if they want
> simple protections for their every-day system use, also, the
> availability of some patch-sets with security enhancements (like
> grsecurity) distracts users of being using the LSM framework or even
> SELinux itself, in addition, this TPE has more features than
> grsecurity's one in terms of per-users and groups acl basis, which make
> easy the management of the TPE protection.
> In short, after a first review you can see that it could worthy to
> include this in the kernel sources.

The two biggest issues are 1) it's trivial to bypass:
$ /lib/ld.so /untrusted/path/to/program
and 2) that there's no (visible/vocal) user base calling for the feature.

So working those issues will help make a better case for mainline
inclusion.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
