Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbUK2LrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUK2LrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUK2Loj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:44:39 -0500
Received: from box.punkt.pl ([217.8.180.66]:8466 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261684AbUK2LnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:43:18 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Mon, 29 Nov 2004 12:41:06 +0100
User-Agent: KMail/1.7
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Jeff Garzik <jgarzik@pobox.com>
References: <19865.1101395592@redhat.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411291241.06712.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On poniedzia³ek 29 listopad 2004 02:28, Linus Torvalds wrote:
> So I would encourage people to think about ways to clean up some of the
> worst warts, but take into account:
>  - testing it out with whatever random collection of old distributions and
>    special applications is almost impossible. So every single step of the
>    way should be (a) small and (b) obviously not break any current users.

If I understand correctly the above means "include/* userland breakage 
problems open for fixing" and the "kernel includes aren't for userland" part 
is obsolete?

>  - cleanup just for the sake of cleanup always needs to take pain into
>    account. If you cannot make each small step "worth it", then just don't
>    do it. If the "cleanup" just adds another file and doesn't actually
>    _help_ anything that you can point to, it's not a cleanup, it's just an
>    exercise in wanking.
>
> IOW, I seriously doubt any "let's reorganize header files just to make it
> look good" _ever_ accomplished anything. But if there are _specific_
> header files that have _specific_ problems, let's look at maybe solving
> those. And if you cannot point to a specific problem with a suggested
> specific solution, please don't cc me.

Potential breakage is mostly a non issue - since vanilla kernel headers are 
mostly useless for userland anyway, one must either patch them or use my 
headers (fedora's?). As for my headers - I can always provide a compatibility 
layer that will look like the old tree but in fact use the new tree.* And 
that also means application specific hacks not to break some app (I'm doing 
that now anyway, so no difference).

I'm *really* for fixing the header problem once and for all one way (lifting 
the 'kernel includes aren't for userland' ban) or the other (making a 
separate, userland available part that glibc and other apps can use cleanly). 
Maintaining a separate tree of those headers ain't much fun and it would be 
nice if I could quit doing that some time in the future.


* Fluent and (mostly) painless migration guaranteed or your money back.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
