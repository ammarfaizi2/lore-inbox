Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271229AbTHHFqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271236AbTHHFqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:46:33 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:39756 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S271229AbTHHFqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:46:30 -0400
Date: Thu, 7 Aug 2003 22:45:45 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: =?iso-8859-1?Q?Mathias_Fr=F6hlich?= <Mathias.Froehlich@web.de>,
       Jerry Cooperstein <coop@axian.com>
Cc: linux-kernel@vger.kernel.org, Luke Howard <lukeh@PADL.COM>
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
Message-ID: <20030807224545.A29285@google.com>
References: <20030807013930.A26426@google.com> <1060267356.1604.10.camel@p3.coop.hom> <200308071506.04890.Mathias.Froehlich@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308071506.04890.Mathias.Froehlich@web.de>; from Mathias.Froehlich@web.de on Thu, Aug 07, 2003 at 03:06:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 03:06:04PM +0200, Mathias Fröhlich wrote:
> I think you can try out the nss_ldap rpm at
> 
> http://na.uni-tuebingen.de/~frohlich/nss_ldap/

Didn't fix my problem.  I'll dig in and narrow this down further.

On Thu, Aug 07, 2003 at 09:42:36AM -0500, Jerry Cooperstein wrote:
> If you read the release notes for RH9 you'll see you can adjust what
> thread library gets used with the environmental variable
> LD_ASSUME_KERNEL.  So for instance you can do:
> 
> LD_ASSUME_KERNEL=2.2.5 rpm ....
> LD_ASSUME_KERNEL=2.2.5 up2date 
> 
> (I've mentioned these two because I've noted these fail when you are
> root...)

Interesting.  Something these have in common is that they all use
Berkeley db4 (up2date by virtue of using rpm).  I don't understand why
nss_ldap or pam_ldap would, but it's one of the sources in the srpm.

But, rpm works for me (both RH and unpatched kernels).

/fc
