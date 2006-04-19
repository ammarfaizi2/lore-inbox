Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWDSRLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWDSRLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWDSRLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:11:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:10692 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751113AbWDSRK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:10:59 -0400
Date: Wed, 19 Apr 2006 12:10:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
Message-ID: <20060419171056.GB1238@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <20060419152129.GA14756@sergelap.austin.ibm.com> <44465C47.9050706@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44465C47.9050706@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> Serge,
> 
> >Please look closer at the patch.
> >I *am* doing nothing with sysctls.
> >
> >system_utsname no longer exists, and the way to get to that is by using
> >init_uts_ns.name.  That's all this does.
> Sorry for being not concrete enough.
> I mean switch () in the code. Until we decided how to virtualize 
> sysctls/proc, I believe no dead code/hacks should be commited. IMHO.
> 
> FYI, I strongly object against virtualizing sysctls this way as it is 
> not flexible and is a real hack from my POV.

Oops, I forgot that was there!

Sorry.

Yup, I'm fine with leaving that out.  After all, nothing in the
non-debugging patchset allows userspace to clone the utsnamespace yet,
so it's tough to argue that leaving out that switch impacts
functionality :)

I believe Dave is working on a more acceptable sysctl adaptation, though
I'm not sure when he'll have a patch to submit.  In any case, one clear
concise piece at a time.

thanks,
-serge
