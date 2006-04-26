Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWDZDm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWDZDm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWDZDmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:42:55 -0400
Received: from web81908.mail.mud.yahoo.com ([68.142.207.187]:54711 "HELO
	web81908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932351AbWDZDmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:42:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Nse3HaWdsoCevHnEU5bABNu1vFNCO9sCeUMTHTjwkzhdsTaZs16hdkTuVT1KUxsec8Xrn0CiedhotvqsczYHtLYbwDEyXWJKB192zOH/rmvhSW0M8+tdAtOD9wKUqYwjNzNHXqlFCXGLMY+v407bzfBltxlSc1fwYDlJXB00Mg0=  ;
Message-ID: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com>
Date: Tue, 25 Apr 2006 20:42:52 -0700 (PDT)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: RE: C++ pushback
To: davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEJOLIAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- David Schwartz <davids@webmaster.com> wrote:

> 
> > > Hahaha. So now, it's not good enough that they not ask you
> > > to do anything,
> > > they have to actively *prevent* you from choosing to waste time on
> their
> > > changes?
> 
> > If you wish to interpret it that way, I won't prevent you :-)
> 
> > Anyway -- what I meant is that even if somebody writes a patch
> changing
> > names to avoid collisions with C++, _merging_ such a patch could be
> > easily a waste of other people's time, especially when there is no
> > other advantage in merging such a patch (like if the reason is that
> > somebody wishes to port his closed-source driver to Linux [*]).
> 
> > [*]: Not that I'm claiming that this is the case now, but it already
> > happened.
> 
> 	You are being ambiguous here, possibly deliberately possibly 
> through honest confusion and possibly because you know what you're 
> saying and can't imagine how anyone else could not understand you. For 
> example, does "merging" mean the process of making the kernel continue 
> to compile cleanly with the patch applied? Or does "merging" mean the 
> effort in maintaining your current level of understanding and 
> proficiency with the kernel once the patch is in the mainline?
> 

How long have you been paying attention here?  0) You're pushing a
non-starter, rudely, and ignoring the pushback, and 1) you don't know how
 patches get merged into mainline.

Merging does involve pretty much all of that.  In consideration of a
patch or patch set for merging, its benefit to the kernel, compliance
with coding standards for the kernel, ease of maintenance of the whole
kernel by a vast, far-flung community of developers after the patch goes
in, the quality of the code, and how nicely its author plays with others
are taken into account.  Patches become part of the kernel.  Patches
belong to everybody once they're accepted, and they have to be workable
for anybody that might have to touch the systems they modify.  If you
rename vast parts of the kernel for no reason other than your wish to
have C++ work in it, you screw up everybody.  Naming is important.

> 	If the former, you are totally correct. Nobody should work on 
> merging a patch they don't believe in. If the latter, then see my 
> criticism.

It isn't about belief.  It's about code.  In point of fact, it isn't even
about you until you become such an irritant that your personality makes
people shy away from your patches.  It is about working well in the
pre-existing structure.  Minimal, focused changes that achieve one goal
per patch, that can be proven useful.

> 
> 	You originally said:
> 
>> As far as they intend to stay away from the main kernel tree, I
>> don't critize anybody. But for example renaming otherwise logically
>> named structure members (`class' etc.) just for C++ compatibility _IS_
>> wasting time of other people, who need to remember new names, review 
>> the patch and so on.
> 
> 	If you don't believe the patch will benefit anyone, the review
> shouldn't take you more than a second or two. You should definitely say
> "I don't believe in this patch, I don't like C++ in the kernel, my 
> review is that it should not go in" and that's it. Nobody is forcing
you
> to work to adopt changes you don't believe in, and you should *not* do 
> so as your part in keeping kernel code quality high.

You are partially correct.  Nobody forces anybody to review or accept a
patch that they believe is in bad taste, or is malformed, or will do Bad
Things to the kernel.  You may, at your discretion, submit all of the
patches you wish to this list, or to Linus, or to Andrew, or anyone you
like.  Should they be for the purpose of converting functioning kernel C
into what you think ought to be functional C++, I can practically
guarantee they will go absolutely nowhere.  

$ cat convert_kernel_to_c++.patch >/dev/null 

would be faster.  You may think of it as pearls before swine if it makes
you feel better, but the kernel devs are being rational.

> 
> 	As for remembering new names, that's a load of complete crap and I
> find it hard to believe that you're raising the argument for honest 
> reasons.
> 

The scale of the kernel, the number and churn of developers, and the
importance of not breaking things in a stable kernel tend to argue
against you.  Humans develop the kernel.  Humans remember names well. 
You may think that's arbitrary, but when you change naming across the
entire kernel, you confuse a very large and diverse group of people who
do this because they enjoy it.  It's hard enough when this has to happen
for useful or necessary reasons; you're asking the kernel developers to
accept it for a completely arbitrary whim that they have rejected
successfully several times in the past.  You want C++?  Fork the freely
available source code at a convenient point and convert it yourself.  As
long as it stays GPL, you're perfectly within your rights so to do. 
Hobson's choice is yours.  Belaboring this point is silly.

MAF


> 	DS
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

