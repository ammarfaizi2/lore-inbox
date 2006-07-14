Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWGNPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWGNPOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWGNPOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:14:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64640 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030457AbWGNPOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:14:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
Date: Fri, 14 Jul 2006 09:13:35 -0600
In-Reply-To: <1152887287.24925.22.camel@localhost.localdomain> (Dave Hansen's
	message of "Fri, 14 Jul 2006 07:28:06 -0700")
Message-ID: <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Thu, 2006-07-13 at 21:45 -0600, Eric W. Biederman wrote:
>> I think for filesystems like /proc and /sys that there will normally
>> be problems.  However many of those problems can be rationalized away
>> as a reasonable optimization, or are not immediately apparent.
>
> Could you talk about some of these problems?

Already mentioned but.  rw permissions on sensitive files are for 
uid == 0.  No capability checks are performed.

>> Passing a file descriptor between process in a unix domain socket is
>> a case where I can easily construct scenarios where there are
>> indisputable problems.  It is one of my standard thought experiments
>> to see if a namespace is sound.
>
> Care to share some of those indisputable problems?

Already done.

Eric
