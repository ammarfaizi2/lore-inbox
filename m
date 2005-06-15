Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVFOWpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVFOWpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVFOWpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:45:45 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:58558 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261619AbVFOWpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:45:04 -0400
Date: Wed, 15 Jun 2005 18:44:22 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Toml@us.ibm.com,
       Greg KH <greg@kroah.com>, Emilyr@us.ibm.com, kylene@us.ibm.com
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <Pine.WNT.4.63.0506151754150.2452@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wright <chrisw@osdl.org> wrote on 06/15/2005 05:53:01 PM:

> * serue@us.ibm.com (serue@us.ibm.com) wrote:
> > Quoting Chris Wright (chrisw@osdl.org):
> > > The primary purpose of the hooks is access control.  Some of them, of
> > > course, are helpers to keep labels coherent.  IIRC, James objected
> > > because the measurement data was simply collected from these hooks.
> > 
> > Ok, so to be clear, any module which does not directly impose some form
> > of access control is not eligible for an LSM?
> 
> That's exactly the intention, yes.

Chris,

Access control is a very broad term. Before I go into details, I would 
like to make clear that I do not have a preference for or against LSM. We 
are working hard to make the functionality available and it does not 
matter to the user where IMA will be located. The true potential of 
Trusted Computing will only show with experimenting going on outside 
the research labs. IMA can help by being one modest building block 
for experiments only if it is broadly available.

Regarding the access control discussion, one can map (almost) anything 
onto access control. There are (many) people that teach today that the 
whole security issue is about access control. The question is: 
controlling access of whom to what?

IMA does control access by forcing measurements on executables
before they are loaded. Access control is more than saying yes or no at 
some point on the code path. IMA enables remote parties to figure out 
whether a system has some (usage dependent) properties. This can serve as 
the basis for controlling such systems' access to resources. IMA supplies 
input into a remote Access Control Decision Function.

These properties neither justify IMA to be excluded as LSM, nor force IMA 
to be an LSM.


> thanks,
> -chris

Thanks 
Reiner

