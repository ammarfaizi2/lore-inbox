Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWGLQMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWGLQMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWGLQMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:12:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:61259 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751450AbWGLQMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:12:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KiX7FWlIvIZoWyWhYxqODpxf7ToHCU3SE/Pd5OZp7M6maM841wDDBSnYLPOz82L3ABzkwT35NPscB7hfijiuk51xsnYYR+M/wcQOBOUcHUWNmtsuN6OSYN+6cp0stEFxyl6NtyGvdbwuHffP4e2WgqFCIRo3GU6jji0wZLVb2nM=
Message-ID: <b0943d9e0607120912o2673ae9ej89580c13d94f5670@mail.gmail.com>
Date: Wed, 12 Jul 2006 17:12:40 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607120833i3bfe1f1bu460d89b2ba0bf935@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120619p6837a64bice7808856f93b11b@mail.gmail.com>
	 <b0943d9e0607120737h691212ddl31d5db4bb1cb3db4@mail.gmail.com>
	 <6bffcb0e0607120833i3bfe1f1bu460d89b2ba0bf935@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 12/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > Here is a slabinfo from current 2.6.18-rc1-git4 and 2.6.18-rc1 +
> > > kmemleak http://www.stardust.webpages.pl/files/o_bugs/kml/slab.txt
> >
> > Thanks. Does it make any difference if you enable
> > CONFIG_DEBUG_MEMLEAK_TASK_STACKS? Also, if you save the memleak file
> > periodically, do any of the context_struct_to_string reports disappear
> > (I can investigate this if you upload a few ml60.txt, mk61.txt etc.)?
>
> Here are the results
> http://www.stardust.webpages.pl/files/o_bugs/kml/ml/

The context_struct_to_string leaks do not seem to disappear in
subsequent ml?.txt files which makes me think it's a real leak.

Thanks for collecting these statistics.

-- 
Catalin
