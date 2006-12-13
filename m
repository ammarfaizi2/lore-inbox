Return-Path: <linux-kernel-owner+w=401wt.eu-S1750843AbWLMWUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWLMWUh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWLMWUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:20:37 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:36767 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbWLMWUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:20:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o7rqRNM81ssGwLo9YH+NO3+lOfVR4SE+vswXibnj3SN3uw8TYhj+JNpQeE8JCVkm6YgSXJ7LsP5+Id5x221acoFcI4x2Ymyr3IfQxCJjio5FoUecas3VpdHfugc7d0RPFqM2FJ60JO7wAPAd6xKgpp5p0YHnynEXFVPVDaRSbW0=
Message-ID: <f2b55d220612131420l5f956e05qb10ef233670fb588@mail.gmail.com>
Date: Wed, 13 Dec 2006 14:20:35 -0800
From: "Michael K. Edwards" <medwards.linux@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Cc: "Martin Bligh" <mbligh@mbligh.org>, "Greg KH" <gregkh@suse.de>,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061213134721.d8ff8c11.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
	 <20061213210219.GA9410@suse.de> <45807182.1060408@mbligh.org>
	 <20061213134721.d8ff8c11.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 13 Dec 2006 13:32:50 -0800
> Martin Bligh <mbligh@mbligh.org> wrote:
>
> > So let's come out and ban binary modules, rather than pussyfooting
> > around, if that's what we actually want to do.
>
> Give people 12 months warning (time to work out what they're going to do,
> talk with the legal dept, etc) then make the kernel load only GPL-tagged
> modules.

IIRC, Linus has deliberately and explicitly estopped himself from
claiming that loading a binary-only driver is a GPL violation.  Do you
really want to create an arbitrage opportunity for intermediaries who
undo technical measures that don't match Linus's declared policy or,
in many people's opinion, the law in at least some jurisdictions?
(I'm not going to go all amateur-lawyer on you, but the transcript of
oral argument at the Supreme Court level in Lotus v. Borland makes
really interesting reading no matter where you live or what your
stance is on GPL-and-linking.)

> I think I'd favour that.  It would aid those people who are trying to
> obtain device specs, and who are persuading organisations to GPL their drivers.

I don't think it would.  There is a strong argument that GPL drivers
in the mainline kernel are a good idea on technical and business
grounds.  Making a federal case out of it is a distraction at best.

There is a widespread delusion that closed driver code is an asset in
an accounting sense.  It costs a lot of money to create and even more
to maintain in any kind of usable condition.  As long as managers of
chip development projects get away with shifting some of the real cost
of creating yet another buggy undocumented one-off CPU interface onto
a "software" team in a different cost center, the pressure to label
the code base an intangible asset is overwhelming.  It usually takes a
reorg or two to diffuse the responsibility enough to call it a sunk
cost, at which point someone might be brave enough to argue that
opening it up would save money and/or sell more chips.

As things stand, there is a slippery slope (in a good way) from a
totally-closed, one-off, buggy vendor driver to a GPL'ed driver in the
mainline kernel.  Customers get impatient for drivers that work, the
vendor allows a customer or a mutually acceptable third party to work
on the code, the sky doesn't fall.  There are some situations where
the business strategy of keeping the driver closed is defensible on
both engineering and regulatory/barrier-to-entry grounds, but they're
fairly rare; and some fraction of vendors come around to that view in
time.

> (Whereas the patch which is proposed in this thread hinders those people)

There we agree.

Cheers,
- Michael
