Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWEYVmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWEYVmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbWEYVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:42:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030413AbWEYVmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:42:02 -0400
Date: Thu, 25 May 2006 17:41:56 -0400
From: Dave Jones <davej@redhat.com>
To: devmazumdar <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525214156.GD4328@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55715+usls@eGroups.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:19:33PM -0000, devmazumdar wrote:
 > How does one check the existence of the kernel source RPM (or deb) on
 > every single distribution?.
 > 
 > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,

Actually, no it doesn't. The kernel source in RHEL4 & Fedora
is an srpm just like every other source package.  Now, if you're 
referring to kernel headers to build modules against, it's still
incorrect, that's a package called kernel-devel.

 > SuSE, Mandrake and CentOS - how about other RPM based distros? How
 > about debian based distros?. There doesn't seem to be a a single
 > conherent naming scheme. 

Why should there be? When people do things independantly, it's
unlikely they all arrive at the same solutions, and converging
back afterwards is difficult once there are deployments in the field.
(Even within 1 distro, when we moved from the kernel-source package
 you referenced, to a .srpm, the fallout went on for *months*[1]).

You seem somewhat surprised at this.  It may sound trivial, but
getting agreement on issues like this across distributions is a
long drawn out process.  (See the LSB archives for some of the
madness surrounding issues like this).

 > Another thing, can we please start enforcing that people ship kernel
 > source with the base installation?

So you want to increase the footprint of everyone's minimal install,
even though the vast majority of users will never need it?
This isn't going to fly.  Not everyone builds add-on modules.

 > If distributors are distributing kernels, then it must be an absolute
 > requirement that they ship kernel sources in a "configured" state as well.

On a Fedora system:  yum install kernel-devel
As mentioned at length in the release notes.

Perhaps if you explain your problem in a less abrasive way instead of
coming here with demands, maybe something can be done to improve
whatever process you feel is failing.

		Dave

[1] Given you seem to have missed this, it could be argued that it's
still ongoing, highlighting just how much of a problem renaming stuff causes.

-- 
http://www.codemonkey.org.uk
