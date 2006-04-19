Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWDSRMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWDSRMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWDSRMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:12:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54409 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751109AbWDSRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:12:17 -0400
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru>
	<20060419152129.GA14756@sergelap.austin.ibm.com>
	<44465C47.9050706@sw.ru> <44466B31.7040700@fr.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 11:10:01 -0600
In-Reply-To: <44466B31.7040700@fr.ibm.com> (Cedric Le Goater's message of
 "Wed, 19 Apr 2006 18:54:09 +0200")
Message-ID: <m1hd4plceu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Hello !
>
> Kirill Korotaev wrote:
>> Serge,
>> 
>>> Please look closer at the patch.
>>> I *am* doing nothing with sysctls.
>>>
>>> system_utsname no longer exists, and the way to get to that is by using
>>> init_uts_ns.name.  That's all this does.
>> Sorry for being not concrete enough.
>> I mean switch () in the code. Until we decided how to virtualize
>> sysctls/proc, I believe no dead code/hacks should be commited. IMHO.
>
> How could we improve that hack ? Removing the modification of the static
> table can easily be worked around but getting rid of the switch() statement
> is more difficult. Any idea ?

Store offsetof in data.  Not that for such a small case it really matters,
but it probably improves maintenance by a little bit.

>> FYI, I strongly object against virtualizing sysctls this way as it is
>> not flexible and is a real hack from my POV.
>
> what is the issue with flexibility ?

The only other thing I would like to see is the process argument passed
in. 

Eric
