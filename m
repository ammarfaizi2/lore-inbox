Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWJ3SBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWJ3SBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWJ3SBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:01:51 -0500
Received: from smtp-out.google.com ([216.239.45.12]:12378 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932135AbWJ3SBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:01:50 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=LBJ9iZZ2o7c9JcxnzAYHGqjWTusz4+7/l4gcuO1i4vsHLscFi5Br9Kz05T9+/rMsT
	ysaSgUVd0B3DrHxq3RMRw==
Message-ID: <6599ad830610301001i2ad35290u63839e920d82a5f4@mail.gmail.com>
Date: Mon, 30 Oct 2006 10:01:40 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
In-Reply-To: <45460743.8000501@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Pavel Emelianov <xemul@openvz.org> wrote:
> > Debated:
> >       - syscall vs configfs interface
>
> 1. One of the major configfs ideas is that lifetime of
>    the objects is completely driven by userspace.
>    Resource controller shouldn't live as long as user
>    want. It "may", but not "must"! As you have seen from
>    our (beancounters) patches beancounters disapeared
>    as soon as the last reference was dropped.

Why is this an important feature for beancounters? All the other
resource control approaches seem to prefer having userspace handle
removing empty/dead groups/containers.

> 2. Having configfs as the only interface doesn't alow
>    people having resource controll facility w/o configfs.
>    Resource controller must not depend on any "feature".

Why is depending on a feature like configfs worse than depending on a
feature of being able to extend the system call interface?

> >       - Interaction of resource controllers, containers and cpusets
> >               - Should we support, for instance, creation of resource
> >                 groups/containers under a cpuset?
> >       - Should we have different groupings for different resources?
>
> This breaks the idea of groups isolation.

That's fine - some people don't want total isolation. If we're looking
for a solution that fits all the different requirements, then we need
that flexibility. I agree that the default would probably want to be
that the groupings be the same for all resource controllers /
subsystems.

Paul
