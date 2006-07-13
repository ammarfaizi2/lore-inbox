Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWGMVXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWGMVXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWGMVXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:23:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:29340 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030393AbWGMVXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:23:17 -0400
Date: Thu, 13 Jul 2006 16:22:18 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060713212218.GA2169@sergelap.austin.ibm.com>
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com> <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com> <m1sll51j3r.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sll51j3r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> >> keys are essentially security credentials for something besides the
> >> local kernel.  Think kerberos tickets.  That makes the keys the
> >> obvious place to say what uid you are in a different user namespace
> >> and similar things.
> >
> > what about performance ? wouldn't that slow the checking ?
> 
> It needs to be looked at, but it shouldn't slow the same namespace
> case,

How so?  The processesing is the same.

> and permission checking is largely a slow path issue.  So a little
> overhead at open time is preferred to overhead after you get the file
> open.

Unsure which approach has overhead after file open...

-serge
