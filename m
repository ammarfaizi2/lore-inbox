Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVC2IKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVC2IKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVC2HYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:24:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14275 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262456AbVC2HDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:03:51 -0500
Date: Tue, 29 Mar 2005 12:43:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] Re: [RFC/PATCH 0/17][Kdump] Overview
Message-ID: <20050329071327.GB3880@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1112016341.4001.71.camel@localhost.localdomain> <20050328174827.414a90a9.akpm@osdl.org> <1112072354.3604.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112072354.3604.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vivek, perhaps a little more context about the background of the
changes would have helped here. Not everyone has been following
the details of fastboot/kdump discussion for the last few months. 

Let me give this a try - Eric/Vivek please pitch in and correct me,
where I go wrong since even I haven't been that tightly plugged
in all the time.

Sometime back kexec underwent a major redesign in some respect. This
was mainly in terms of the division of responsibilities between the 
kernel and user-space kexec-tools. For kdump in particular this also
had to do with the real groundwork being set for better integration
into kexec mainstream, and a more reliable and cleaner interface between
what happens in kexec-tools, in the old kernel's context and in the
new kernel's context. On the whole, a better world for all :)

However, at that time, when this new revamped kexec was integrated
into -mm, the corresponding kdump redesign was still pending -- which
is why the *old* crash dump patches in -mm were kind of irrelevant
and broken because they hadn't caught up with the kexec revamp. Which
is also why kdump wasn't being tested on -mm ... it didn't even work !

Sorting this all out is really what I see Vivek's latest patches being 
intended for -- and I believe it is the outcome of the work that has
been happening on fastboot over the last several months ?
This is why, I guess, it made sense for him to take the route of
throwing out most of the old patches and starting afresh with new
ones, because these are *built* on a different foundation altogether,
so incremental patches would have been rather confusing.

This should not be a continuing trend from here on (I hope not
at least, since major revamps are quite costly on stability !),
so shouldn't be a cause for worry. The bullet has been bitten. From
here on, changes must be incremental.

Regards
Suparna

On Tue, Mar 29, 2005 at 10:29:13AM +0530, Vivek Goyal wrote:
> On Mon, 2005-03-28 at 17:48 -0800, Andrew Morton wrote:
> > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > >
> > >  Following patches (as in series file) need to be dropped before applying
> > >  the fresh ones.
> > > 
> > >  crashdump-documentation.patch
> > >  crashdump-memory-preserving-reboot-using-kexec.patch
> > >  crashdump-routines-for-copying-dump-pages.patch
> > >  crashdump-routines-for-copying-dump-pages-fixes.patch
> > >  crashdump-elf-format-dump-file-access.patch
> > >  crashdump-linear-raw-format-dump-file-access.patch
> > >  crashdump-linear-raw-format-dump-file-access-coding-style.patch
> > 
> > At some point we should stop tossing out patches and replacing them in this
> > manner.
> 
> 
> Andrew, I shall take care of sending incremental patches only next time
> onwards. The reason why I did this because changes were relatively large
> and I thought dropping the existing series and replacing it with new
> series (some patches retaining the old name) might be a better idea.
> 
> 
> > Because doing so makes it hard for people to see what has changed.  
> > 
> > It makes it hard for people to see that changes in the above patches
> > haven't been simply lost.
> > 
> > And the fact that you were probably working against some kernel other than
> > -mm gives little confidence that the kdump development team have been
> > testing the patches which are presently in -mm.  And that is what they are
> > there for.
> > 
> > 
> > 
> 

> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/fastboot


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

