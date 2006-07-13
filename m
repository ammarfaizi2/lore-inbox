Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWGMRhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWGMRhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWGMRgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:36:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16861 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751427AbWGMRgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:36:44 -0400
Message-ID: <44B684A5.2040008@fr.ibm.com>
Date: Thu, 13 Jul 2006 19:36:37 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>	<20060711075420.937831000@localhost.localdomain>	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>	<44B50088.1010103@fr.ibm.com> <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>> I think user namespace should be unshared with filesystem. if not, the
>> user/admin should know what is doing.
> 
> No.  The uids in a filesystem are interpreted in some user namespace
> context.  We can discover that context at the first mount of the
> filesystem. 

ok. so once you're in such a user namespace, you can't unshare from it
without loosing access to all your files ?

> Assuming the uids on a filesystem are the same set of uids your process
> is using is just wrong.

well, this is what is currently done without user namespaces.

>>> I believe some of the key infrastructure which is roughly kerberos
>>> authentication tokens could be used for this purpose.
>> please elaborate ? i'm not sure to understand why you want to use the keys
>> to map users.
> 
> keys are essentially security credentials for something besides the
> local kernel.  Think kerberos tickets.  That makes the keys the
> obvious place to say what uid you are in a different user namespace
> and similar things.

what about performance ? wouldn't that slow the checking ?

thanks,

C.
