Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRC3Cs2>; Thu, 29 Mar 2001 21:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRC3CsS>; Thu, 29 Mar 2001 21:48:18 -0500
Received: from [204.244.205.25] ([204.244.205.25]:17444 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S130448AbRC3CsH>;
	Thu, 29 Mar 2001 21:48:07 -0500
Subject: Re: OOM killer???
From: Michael Peddemors <michael@linuxmagic.com>
To: David Konerding <dek_ml@konerding.com>
Cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <3AC357B8.72860494@konerding.com>
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int>
	<Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de>
	<20010329130154.A8701@win.tue.nl>  <3AC357B8.72860494@konerding.com>
Content-Type: text/plain
X-Mailer: Evolution (0.9 - Preview Release)
Date: 29 Mar 2001 18:26:32 -0800
Mime-Version: 1.0
Message-Id: <20010330024815Z130448-406+5643@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking over the last few weeks of postings, there are just WAY to many
conflicting ways that people want the OOM to work..  Although an
incredible amount of good work has gone into this, people are definetely
not happy about the benifits of OOM ...  About 10 different approaches
are being made to change the rule based systems pertaining to WHEN the
OOM will fire, but in the end, still not everyone will be happy..

The old way of having a machien crash when you asked too much of it
seemed acceptable.. People then either chose to run the mem hog, and
upgrade their boxes, or they stopped running the memhog.

Maybe its time to hear from on high whether OOM capability outweighs the
problems that seem to be associated with it?

Either that or we should be able to allow the end user/and the distros
to decide what gets killed by OOM.

Some people might like to just say to heck with it, and not let anything
get killed, while others may just want to protect certain things.. 

Speaking completely where I don't belong, and don't know enough about..
Just a thought, can we come up with a new form of execute bit that would
define whether OOM should affect the process?  Then the app can be made
to be killable if not as root etc...  As well as being applied simply at
a per application basis, because we KNOW that not all applications will
ever be completely system friendly..
There will always be useful programs that might not fit into a OOM model
well.

Linus has been notably quite of late about this issue, given the amount
of contention on this issue..

On 29 Mar 2001 07:41:44 -0800, David Konerding wrote:

> Now, if you're going to implement OOM, when it is absolutely necessary, at the very
> least, move the policy implementation out of the kernel.  One of the general
> philosophies of Linux has been to move policy out of the kernel.  In this case, you'd
> just have a root owned process with locked pages that can't be pre-empted, which
> implemented the policy.  You'll never come up with an OOM policy that will fit
> everybody's needs unless it can be tuned for  particular system's usage, and it's
> going to be far easier to come up with that policy if it's not in the kernel.

-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
WizardInternet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

