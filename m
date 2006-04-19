Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWDSQyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWDSQyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWDSQyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:54:14 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:14556 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750952AbWDSQyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:54:13 -0400
Message-ID: <44466B31.7040700@fr.ibm.com>
Date: Wed, 19 Apr 2006 18:54:09 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <20060419152129.GA14756@sergelap.austin.ibm.com> <44465C47.9050706@sw.ru>
In-Reply-To: <44465C47.9050706@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Kirill Korotaev wrote:
> Serge,
> 
>> Please look closer at the patch.
>> I *am* doing nothing with sysctls.
>>
>> system_utsname no longer exists, and the way to get to that is by using
>> init_uts_ns.name.  That's all this does.
> Sorry for being not concrete enough.
> I mean switch () in the code. Until we decided how to virtualize
> sysctls/proc, I believe no dead code/hacks should be commited. IMHO.

How could we improve that hack ? Removing the modification of the static
table can easily be worked around but getting rid of the switch() statement
is more difficult. Any idea ?

> FYI, I strongly object against virtualizing sysctls this way as it is
> not flexible and is a real hack from my POV.

what is the issue with flexibility ?

thanks,

C.
