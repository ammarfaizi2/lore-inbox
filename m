Return-Path: <linux-kernel-owner+w=401wt.eu-S1161011AbWLTX2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWLTX2T (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWLTX2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:28:19 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:34146 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161011AbWLTX2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:28:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GTTC84w4se6a24zuzyh0/vC7vrI+fV+70P8OOMLouSKRa7uz/zaVHH1P6utIc3hkpiAIuWH957DNcZWHj+bekHtnTBY/s1AlboDiHJiwDX0aL3DALXm+eaDfVgkIQwGqSOD/diqOa63gHWoyvsf/1gdpYq23ojB3yxzsMKkNhSk=
Message-ID: <7b69d1470612201528w7d855875q17f9b3e2b5869018@mail.gmail.com>
Date: Wed, 20 Dec 2006 17:28:16 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Alexandre Oliva" <aoliva@redhat.com>
Subject: Re: GPL only modules
Cc: "D. Hazelton" <dhazelton@enter.net>, "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Ricardo Galli" <gallir@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <orac1j2xcm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612161927.13860.gallir@gmail.com>
	 <86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com>
	 <orlkl56lgi.fsf@redhat.com> <200612182242.33759.dhazelton@enter.net>
	 <orac1j2xcm.fsf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Alexandre Oliva <aoliva@redhat.com> wrote:
> On Dec 19, 2006, "D. Hazelton" <dhazelton@enter.net> wrote:
>
> > However I have a feeling that the lawyers in the employ of the
> > companies that ship BLOB drivers say that all they need to do to
> > comply with the GPL is to ship the glue-code in source form.
>
> > And I have to admit that this does seem to comply with the GPL - to the
> > letter, if not the spirit.
>
> I don't see that it does comply even with the letter.  Consider this:
>
>   These requirements apply to the modified work as a whole.  If
>   identifiable sections of that work are not derived from the Program,
>   and can be reasonably considered independent and separate works in
>   themselves, then this License, and its terms, do not apply to those
>   sections when you distribute them as separate works.  But when you
>   distribute the same sections as part of a whole which is a work
>   based on the Program, the distribution of the whole must be on the
>   terms of this License, whose permissions for other licensees extend
>   to the entire whole, and thus to each and every part regardless of
>   who wrote it.
>
> The work, in this case, is the GPLed glue code, in source form, and
> the binary blob, without sources.  See that, even though the binary
> blob is an independent and separate work in itself, and so it can
> indeed be distributed separaly under a different license, when it's
> distributed as part of a whole, then the whole must be on the terms of
> the GPL.
---

The question is what "the whole work" is. If the binary is not a
derived work, and is not prelinked with the work, then it seems likely
to be considered merely an aggregation, not requiring GPL licensing.
Note that there's some difficulty in the language, in that the GPL
uses "work based on the work" to mean something that it defines
specifically, while the Copyright Act defines "derived work" as "work
based on the work". THere is no equivalence there - The GPL's "work
based on the work" includes cases that do not fit the Act's
definition.

So, the GPL's requirement for licensing under the GPL clearly applies
to prelinked binaries, but it is not at all clear that it would apply
to a binary object, not derived from the kernel, shipped on the same
media. That is, the aggregation is NOT a modification of the original
work, it's just an aggregation (work of colective authorship).

---
> ...
> Let's assume they're not intentionally violating the GPL, but rather
> that they believe they're entitled to do what they're doing, i.e.,
> that they believe (a) their glue code is not a derived work from
> Linux.
>
> In this case, they *can* distribute the glue source code under the GPL
> along with their binary blob.  But can anyone else?
>
> Methinks anyone else would be entitled to pass the same whole along
> under the GPL, per section 1, but wouldn't be entitled to distribute
> modified versions, because this would require the derived work to be
> licensed under the GPL, and nobody else is able to provide the source
> code to the binary blob.
---

I'm confused here.  If the glue code is not a derived work, then they
don't need to use the GPL at all. If they DO ue the GPL, then (as you
note) if they didn't include the source code, nobody else could
redistribute it because nobody else would be able to meet the license
terms. I would expect that if they were going to GPL the glue code,
they would also provide the source for it.

---
>...
> Well...  Not quite.  For one, even if enabling others to distribute
> glue code + binary blobs were a good thing, using somebody else's glue
> code means you're bound by the GPL requirements, so you can't ship the
> combination of the glue code with your binary blob.
---

Only if you assume that using the glue code would make your blob a
derived work of the glue code. In many cases the point of the glue
code is to be an adapter between Linux and an existing interface. In
such a case, any binary blob using that interface would not be a
derived work of the glue code.

As before, though, if you linked the binary blob with the glue code
object, then the combined object probably would be a derived work and
have to conform to the GPL.

---
> ...
> So, even if condoning binary blobs were morally acceptable, we still
> wouldn't be gaining anything from this relationship, we'd only be
> enabling vendors to sell us their undocumented hardware while denying
> us our freedoms.
>
> Why should we do this?
---

To enable the use of the hardware in Linux systems? Most people would
prefer well-documented hardware with free drivers, but when that isn't
available, many people might still like to be able to use the
hardware. It's less than ideal, but so is having no way at all to use
the hardware.

scott
