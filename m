Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWGNDvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWGNDvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWGNDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:51:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21396 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161236AbWGNDvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:51:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<m1sll51j3r.fsf@ebiederm.dsl.xmission.com>
	<20060713212218.GA2169@sergelap.austin.ibm.com>
Date: Thu, 13 Jul 2006 21:50:17 -0600
In-Reply-To: <20060713212218.GA2169@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Thu, 13 Jul 2006 16:22:18 -0500")
Message-ID: <m13bd4zvye.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> >> keys are essentially security credentials for something besides the
>> >> local kernel.  Think kerberos tickets.  That makes the keys the
>> >> obvious place to say what uid you are in a different user namespace
>> >> and similar things.
>> >
>> > what about performance ? wouldn't that slow the checking ?
>> 
>> It needs to be looked at, but it shouldn't slow the same namespace
>> case,
>
> How so?  The processesing is the same.

If you do mapping of uids that would not trigger if you have
matching user namespaces.

>> and permission checking is largely a slow path issue.  So a little
>> overhead at open time is preferred to overhead after you get the file
>> open.
>
> Unsure which approach has overhead after file open...

I don't know that I have seen that one yet.  Sorry this was generally
a statement of principle.

Eric

