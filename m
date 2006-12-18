Return-Path: <linux-kernel-owner+w=401wt.eu-S1754083AbWLROfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbWLROfO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 09:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbWLROfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 09:35:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45882 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbWLROfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 09:35:12 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tomas Carnecky <tom@dbservice.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       James Porter <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers
References: <loom.20061215T220806-362@post.gmane.org>
	<20061215220117.GA24819@martell.zuzino.mipt.ru>
	<4583527D.4000903@dbservice.com>
Date: Mon, 18 Dec 2006 07:34:51 -0700
In-Reply-To: <4583527D.4000903@dbservice.com> (Tomas Carnecky's message of
	"Sat, 16 Dec 2006 01:57:17 +0000")
Message-ID: <m13b7ds25w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky <tom@dbservice.com> writes:

> Alexey Dobriyan wrote:
>> On Fri, Dec 15, 2006 at 09:20:58PM +0000, James Porter wrote:
>>> For what it's worth, I don't see any problem with binary drivers from
> hardware
>>> manufacturers.
>>
>> Binary drivers from hardware manufacturers are crap. Learn it by heart.
>>
>
> That's your personal opinion! A lot other people (including me) have had
> excellent experience with binary drivers!

Almost all software is crap.  Binary drivers are just unreviewed unfixable
crap.  Things don't get better if you encourage crap.

The practical problem with simple testing for detecting problems is that
you don't frequently test the corner cases, and corner cases are what
developers often get wrong, often make software a security hazard, and
are often what developers spend most of their time building
infrastructure for so that we can get the corner cases right.

One such corner case that causes me to run in fear of binary only
kernel drivers are times when drivers accidentally write to variables
used for something else.  Which can cause failure somewhere else
someplace a long time after it has happened.  Like driving over a
tack in the road and having your tire go flat 1000 miles later because
of a slow leak.

These are the kinds of problems you have to address if you want
everyone to have a good experience with their hardware.  These are
precisely the kinds of problems that cannot be addressed with
binary only drivers.


We have a process that has worked for centuries to improve our
knowledge base.  The scientific method and peer review.  We use a
variation of this proven process for writing software in linux.  The
binary only vendors are being rude and refusing to participate. 

Do you understand why we have no sympathy for their efforts, no desire
to make their lives easier.

In general people doing binary only drivers are being rude.

> The day you show me that the open-source driver is faster and more stable then
> the binary driver, I'll switch. But until then I'll stay with my binary
> driver. I haven't had any serious problems with it, in fact, I'm very happy, so
> why should I want to switch?

Oh.  So you have had problems with it.   The goal for system software
is quality so high you can not find problems with it.  That doesn't
always happen but we try.  The fact you have minor problems indicates
there are problems in the driver, and which probably means that
it is indeed crap.

Anytime an end user has to be aware of drivers and not the problem
at hand it is a problem.

> I don't see Linux in such a political way like some of you do, for me Linux is
> just like any other OS. There are good drivers and bad drivers. And I don't care
> if they are open source or binary, I don't judge them based on that, but based
> on how well they work and how good the support is.

A very reasonable attitude.  But a binary driver is an automatic
negative on the support side.  It fundamentally reduces the number and
quality of the people who can support you.  The developers are not
being cooperative with other developers so the system as a whole
cannot improve to support it better.


Eric
