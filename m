Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263693AbVBCMJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbVBCMJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbVBCMIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:08:09 -0500
Received: from science.horizon.com ([192.35.100.1]:12341 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262666AbVBCMFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:05:02 -0500
Date: 3 Feb 2005 12:04:54 -0000
Message-ID: <20050203120454.5815.qmail@science.horizon.com>
From: linux@horizon.com
To: frnk_kln@yahoo.com
Subject: Re: Copyright / licensing question
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll respond in terms of U.S. law; if you want something else, please
mention it.

You might find a lot of useful information at
http://fairuse.stanford.edu/Copyright_and_Fair_Use_Overview/chapter9/index.html
http://www.usg.edu/admin/legal/copyright/#part3d3a
http://en.wikipedia.org/wiki/Fair_use
ttp://www.nolo.com/lawcenter/ency/article.cfm/ObjectID/C3E49F67-1AA3-4293-9312FE5C119B5806/catID/2EB060FE-5A4B-4D81-883B0E540CC4CB1E

> 1. For explaining the internals of a filesystem in detail, I need to
>    take their code from kernel sources 'as it is' in the book. Do I need
>    to take any permissions from the owner/maintainer regarding this ?
>    Will it violate any license if reproduce the driver source code in
>    my book ??

This is exactly the sort of "Comment and criticism" that is anticipated
and covered by the fair use exemption.  In judging whether the use is
fair, 17 USC 107 says:

# § 107. Limitations on exclusive rights: Fair use
# 
# Release date: 2004-04-30
# 
# Notwithstanding the provisions of sections 106 and 106A, the fair use
# of a copyrighted work, including such use by reproduction in copies
# or phonorecords or by any other means specified by that section, for
# purposes such as criticism, comment, news reporting, teaching (including
# multiple copies for classroom use), scholarship, or research, is not
# an infringement of copyright. In determining whether the use made of a
# work in any particular case is a fair use the factors to be considered
# shall include:
# (1) the purpose and character of the use, including whether such use
#     is of a commercial nature or is for nonprofit educational purposes;
# (2) the nature of the copyrighted work;
# (3) the amount and substantiality of the portion used in relation to
#     the copyrighted work as a whole; and
# (4) the effect of the use upon the potential market for or value of
*     the copyrighted work.
# The fact that a work is unpublished shall not itself bar a finding
# of fair use if such finding is made upon consideration of all the above
# factors.

Going through those in your case, they are:

1. The Transformative Factor: The Purpose and Character of Your Use

It's commercial use, but the non-commercial exemptions are a relatively
recent addition to copyright law.  The original, classic "fair use"
is commentary and criticism.

I.e. are you adding something to the quoted material?  Have you added
new information or insights?  This is one of the most important factors,
and in your case, assuming the book is worth anything at all, the answer
is clearly "yes".

On this ground alone, you're probably safe.

2. The Nature of the Copyrighted Work

Scope for fair use is broader for published than unpublished works
(because the potential future value of an unpublished work is affected
more by copious excerpting), and broader for factual works than fiction
(because facts and ideas cannot be copyrighted, so it takes more quoting
to include a threshold amount of copyrightable "expression").

The Linux kernel is clearly "published", and while the second part is
a little fuzzy (and I'm not eager enough to chase it back to original
case law), I think the functional nature of software places it in the
"factual" category.

3. The Amount and Substantiality of the Portion Taken

Your publisher won't let you waste enough paper to print a huge fraction
of the Linux kernel.  Yes, it may be a lot of code, but it's not going
to be "most" by a long shot.

In general the standard is that "no more was taken than was necessary"
to achieve the purpose for which the copying was done.  I think you'll
do this anyway, and the law doesn't require you to be super anal about
eliding every snippet and #define that's not directly referenced.

The Lions book, in contrast, included most of 6th edition Unix,
leading to the need for negotiations.  Also, the 6th edition wasn't
publushed, leading to problems with the previous factor.

The legally fuzzy isse is what constitutes a "work" here.  The function?
The source file?  The tarball?  I'd have to look for a case involving
copying of entire entries from an encyclopedia or dictionary to get it
fully untangled.

However, you're helped here by the GPL, which can be used to show
the original author's intentions.  It defines the "work" as an entire
program, that compiles to an executable that does something.  As long
as your excerpts don't compile to a working kernel, you're pretty safe.

4. The Effect of the Use Upon the Potential Market

Will it hurt the copyright owner?  This is typicaly expressed in terms
of income, which doesn't apply very much.  But your intent is clearly to
*add* value to the Linux kernel, so this factor militates in your favor.


> 2. I will write some custom drivers also for illustration. For this
>    I shall include kernel headers.  I also intend to put this in the
>    book. From whom I need to take permission regarding this ? The book
>    will be supported by a web-site. I have no problems in releasing
>    my custom code under GPL. But Am I violating any license by putting
>    the code in the book ?

Do you mean your code, or the headers?  If it's your code, obviously you
can do whatever you like with it.  (The GPL imposes on derived works a
minimum standard of access.  You are free to exceed that by granting
additional alternative permission.)

For the headers, I'm not sure why you'd bother to include ones you're
not commenting on.  It's not as if the code will work without a
computer and a compiler, at which point the person can get the Linux
code in machine-readable form easily enough.


However, you can go at it a different way... if you want to include large
code dumps without commentary, you can segregate them into an appendix and
claim the "mere aggregation" exemption in the GPL for the storage medium
of the printed book!  If it's not commented on or logically attached
to the text of the book, but merely background material for some text
(your file system) which is both GPLed (thus obeying the "derived works"
rule) and used in the book with non-GPL permission (since it's your work).

Let me recap that logical gavotte again:
- As much as Some Corrupt Organizations would like it to be, the copyright
  notion of "derived work" is not strictly transitive.  It is possible
  for B to be derived from A and C to be derived from B without C being
  a derived work of A.
- It can be argued that the book is a derived work of your example file
  system, and the example file system is a derived work of existing Linux
  kernel code, but that's okay.  Your example file system is making allowed
  use of the Linux code because it's GPLed.  And your book is making allowed
  use of your example file system because you can give yourself permission.
- The issue is, to what extent is the book a derived work of the Linux kernel.
  Well, obviously it is, but it's a "comment and criticism" work protected
  by Fair Use.  You have to look at the four factors above.
- You can also include large code dumps as "background material" if your
  book is NOT derived from them (you don't describe or quote from them)
  but they are "merely aggregated on the same storage medium".


As a practical matter, I'd:
- Ask some of the major contributors to the bits you're working on.
  "I'm pretty sure this is fair use, but I don't want to have to go
  through a lawsuit to prove it.  Are you going to be very upset if I
  quote chunks of your code?"  If someone is says "yes, I don't like it",
  THEN you need to go see a lawyer and get your ass covered if you
  want to go ahead.

- On the copyright notice page of the book, explain that the Linux code
  is copyrighted by its various authors and the book does not claim
  copyright over it.  There's no need to explain the GPL here; it's
  just a matter of not asserting ownership.

- The same notice on any code dump appendix.  Make it as "separate" a
  thing as possible.  For example, you might change the running header
  and footer.

The first point is the important one.  It will also help you assert the
good faith fair use defense in 17 USC 504(c)(2).  For avoiding hassles,
it's more important to avoid the lawsuit than to worry about whether
you'd win it.  (Of course, with rational people, a good argument that
you probably will win it will help discourage the lawsuit.)


Frankly, I don't think anyone's going to object.  You would have heard
carping about the other Linux kernel code commentary books if people
objected.
