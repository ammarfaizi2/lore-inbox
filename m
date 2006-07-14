Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWGNSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWGNSHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWGNSHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:07:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26008 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422684AbWGNSHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:07:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<20060713214101.GB2169@sergelap.austin.ibm.com>
	<m1y7uwyh9z.fsf@ebiederm.dsl.xmission.com>
	<20060714140237.GD28436@sergelap.austin.ibm.com>
	<m1k66gw88t.fsf@ebiederm.dsl.xmission.com>
	<20060714163905.GB25303@sergelap.austin.ibm.com>
	<m1mzbct895.fsf@ebiederm.dsl.xmission.com>
	<1152897846.24925.83.camel@localhost.localdomain>
Date: Fri, 14 Jul 2006 12:06:00 -0600
In-Reply-To: <1152897846.24925.83.camel@localhost.localdomain> (Dave Hansen's
	message of "Fri, 14 Jul 2006 10:24:06 -0700")
Message-ID: <m1u05krrhz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Fri, 2006-07-14 at 11:18 -0600, Eric W. Biederman wrote:
>> /proc/<pid>/fd/...
>> /proc/<pid>/exe
>> /proc/<pid>/cwd
>> 
>> It isn't quite the same as you are actually opening a second
>> copy of the file descriptor but the essence is the same. 
>
> Last I checked, those were symlinks and didn't work for things like
> deleted files.  Am I wrong?

Yes.  They are not really symlinks.

Wanting to have an executable that was deleted after it was done
executing.  I wrote it to a file. opened it, unlinked it, set close
on exec, and the exec'd it with /proc/self/fd/N.

Eric
