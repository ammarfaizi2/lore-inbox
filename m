Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVH3Xfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVH3Xfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVH3Xfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:35:31 -0400
Received: from smtp.istop.com ([66.11.167.126]:47302 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751440AbVH3Xfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:35:31 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Date: Wed, 31 Aug 2005 09:35:29 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <200508310925.22567.phillips@istop.com>
In-Reply-To: <200508310925.22567.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310935.29452.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 09:25, Daniel Phillips wrote:
> On Wednesday 31 August 2005 09:13, Joel Becker wrote:
> > On Wed, Aug 31, 2005 at 08:54:39AM +1000, Daniel Phillips wrote:
> > > But it would be stupid to forbid users from creating directories in
> > > sysfs or to forbid kernel modules from directly tweaking a configfs
> > > namespace. Why should the kernel not be able to add objects to a
> > > directory a user created? It should be up to the module author to
> > > decide these things.
> >
> > 	This is precisely why configfs is separate from sysfs.  If both
> > user and kernel can create objects, the lifetime of the object and its
> > filesystem representation is very complex.  Sysfs already has problems
> > with people getting this wrong.  configfs does not.
>
> Could you please give a specific case?

More to the point: what makes you think that this apparent ruggedness will
diminish after being re-integrated with sysfs?  If you wish, you can avoid
any dangers by not using sysfs's vfs bypass api.  It should be up to the
subsystem author.

Regards,

Daniel
