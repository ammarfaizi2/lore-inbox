Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVFOXCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVFOXCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVFOXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:02:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261664AbVFOXAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:00:07 -0400
Date: Wed, 15 Jun 2005 15:59:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, serue@us.ibm.com,
       James Morris <jmorris@redhat.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Toml@us.ibm.com,
       Greg KH <greg@kroah.com>, Emilyr@us.ibm.com, kylene@us.ibm.com
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615225951.GU9046@shell0.pdx.osdl.net>
References: <Pine.WNT.4.63.0506151754150.2452@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0506151754150.2452@laptop>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Reiner Sailer (sailer@us.ibm.com) wrote:
> Access control is a very broad term. Before I go into details, I would 
> like to make clear that I do not have a preference for or against LSM. We 
> are working hard to make the functionality available and it does not 
> matter to the user where IMA will be located. The true potential of 
> Trusted Computing will only show with experimenting going on outside 
> the research labs. IMA can help by being one modest building block 
> for experiments only if it is broadly available.

Yeah, understood.

> Regarding the access control discussion, one can map (almost) anything 
> onto access control. There are (many) people that teach today that the 
> whole security issue is about access control. The question is: 
> controlling access of whom to what?

OK, let's look at it another way.  Say your access control model used
kernel profiling data as part of policy.  It still makes sense to let
oprofile do that collection, and the LSM is just a consumer of that
data when it makes an acces control decision.  Perhaps a klunky analogy,
but do you see the idea?

> IMA does control access by forcing measurements on executables
> before they are loaded. Access control is more than saying yes or no at 
> some point on the code path. IMA enables remote parties to figure out 
> whether a system has some (usage dependent) properties. This can serve as 
> the basis for controlling such systems' access to resources. IMA supplies 
> input into a remote Access Control Decision Function.

Right, the measurement data collection stand alone, which no access
control decisions in sight (talking about the IMA LSM now), is what
tipped the scale.

thanks,
-chris
