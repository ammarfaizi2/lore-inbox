Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWIZPyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWIZPyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWIZPyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:54:22 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:43493 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S932143AbWIZPyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:54:20 -0400
Subject: Re: [PATCH 0/7] Integrity Service and SLIM
From: David Safford <safford@watson.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge E Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060919190214.GA7210@elf.ucw.cz>
References: <1158083845.18137.10.camel@localhost.localdomain>
	 <20060914165113.3067c4b0.akpm@osdl.org>  <20060919190214.GA7210@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 11:53:59 -0400
Message-Id: <1159286039.4718.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 21:02 +0200, Pavel Machek wrote: 
> On Thu 2006-09-14 16:51:13, Andrew Morton wrote:
> > 
> > Having carefully reviewed your code I have come to the firm conclusion that
> > it is written in C.  The next step is to put it all in -mm and see if
> > anyone shouts at me.
> 
> Hmmm, "it is written in C" does not seem like good enough reason to
> merge it... right?

He did go on to say:

>> I'll need help on the upstream-merge decision.
>>
>> A convincing statement of interest (or, better, intent) from vendors 
>> ie: the people who will deliver and support this into the target 
>> users) would help a lot.  Where do we stand with that?

which makes it clear that we also have to show value, interest, and
support. (And, yes, we are working on showing that...)

> I tried to understand what it is good for, but it seems that in
> current state it is not much good for anything.

Part of the problem is that this patch set is just one small part
of the overall architecture, which includes an additional kernel
module to implement the integrity service used by SLIM, and user 
space libraries and tools to implement/manage the trusted boot, 
integrity mandatory access control, and secure authentication features.
We were asked to submit this in small pieces to make the review easier,
and what you see so far is just the first piece, with the others
coming shortly.

We deeply appreciate all the review and comments that happened
along the path of getting into -mm. It has made the code much better,
and makes it easier to work with our partners to start to show long 
term interest and support.

> 
> Will IBM work at splitting ssh so that trusted/untrusted portions are
> separated?

The trousers project at sourceforge already has provided TPM support 
for openSSL, and ssh uses the openSSL crypto library - I'm not sure 
if this directly translates to TPM support for ssh, but that's 
certainly something we want to enable, and I'll check into it.

dave

