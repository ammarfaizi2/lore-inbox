Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136169AbRATAJx>; Fri, 19 Jan 2001 19:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136897AbRATAJm>; Fri, 19 Jan 2001 19:09:42 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:19571 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S136169AbRATAJd>; Fri, 19 Jan 2001 19:09:33 -0500
Message-ID: <3A68D725.DA5409A9@linux.com>
Date: Sat, 20 Jan 2001 00:09:09 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark I Manning IV <mark4@purplecoder.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Coding Style
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark I Manning IV wrote:

> Tabs are 8 characters so NO tabs should be used in ANY source file what
> so ever.  There are some silly people that insist on hitting the tab key
> when they should really be hitting the SPACE key (and for your info Linus
> PI is EXACTLY 3... ish :)

If one is intelligent enough to use the TAB then everyone is free to indent
and thereby display indent in their preferred spacing.  Those of us that use
80c pages can shrink tabs down to a 2sp or 3sp while those of us that have
150c pages can expand them to 10sp if we so choose.

Silly person.  Don't force your style on others by using spaces.


> Rationale:  Tabs force your code out to the right edge of the display
> leaving no room for comments.  You don't need great big gaping spaces to
> delineate the start and end of a block, TWO spaces do this just fine.

Tabs are tabs for a reason, you can delineate tabular columns as you choose.


> Note that the closing brace is empty on a line of its own, _except_ in
> the cases where it is followed by a continuation of the same statement,
> ie a "while" in a do-statement or an "else" in an if-statement, like
> this:
>
>   do
>   {
>     body of do-loop     // why do you insist on not commenting ?
>   } while (condition);  // more on this later :)

Looks a little inconsistent, why don't you put the opening brace on the same
line as 'do'.



> Linus states that the placement of the first brace at the end of the
> first line keeps your code less vertical and thus saves you some space
> for comments.  This commenting style just plane sucks, it fragments your
> source file creating all kinds of visual clutter making them impossible
> to read.  New lines ARE A RENEWABLE resource, if they aren't then you need
> to buy more ram for your 8086 (or is it a z80 ?).

Your style sucks.  Trying to up your line count on your project?


> code                    // comment
> {
>   code                  // comment
>   code                  // comment
> }
>
> ...is much neater and also takes up allot less vertical space (thus
> blowing the argument Linus was making about braces eating up
> real estate).  Yes we could shrink this further by bracing as per
> K&R but that would only serve to cram everything into an unreadable
> blob.  SOME whitespace IS needed!!

Not when your code and your comment are required to span multiple lines.  It
is much easier to read a paragraph describing the following code than it is
to read a very short snip on each line, often the code and comments out of
sync with the line they are on due to lack of space.


> One other thing.  Allot of people neglect to brace a statement if
> it has a single line body.  This is VERY bad, always brace your
> statements....
>
>  if (x = 1)
>    if (y = 2)
>      if (z = 3)
>        for (i = 1; i < 10; i++)
>          if ....
>            switch (foo)
>              .....
>
> ...is really stupid.  DON'T DO IT!

No, it's really stupid to surround it with braces that aren't needed. The
above is incredibly easy to read and incredibly easy to trace and debug.


> I would however like to state that the C switch statement is evil and
> to be avoided at all costs.  If you really need to use one for what
> ever reason then each case in that switch statement should be a
> CALL TO A FUNCTION!  Never place the source for that function inline
> unless it is only ONE line of code (or at a push TWO lines).  You can
> always make the compiler inline it for you!!!

I happen to love the switch function, it's incredibly useful.  I don't know
what your issue is if you can't keep a context of a dozen lines in a case
block.  I agree that 500 lines is too much, but limiting it to two, much less
one, is brain damaged.


> Even if its only 9 or 10 lines of code you STILL lose context on the
> switch statement.  Poorly factored code is difficult to read. Very few
> C coders know how to factor their code well.

It seems you fit into this group.


> Comments are good, the more you comment your code the better. These
> comments are not for you, they are for the poor schmuck that has to
> deal with your scratching later.  Never underestimate the stupidity
> of this guy, don't leave anything to chance.  Never assume that HE
> will understand your logic simply because YOU do.

In other words, DOCUMENT.  Don't put very short snippets of vague reference
on the end of a line of code.  Don't clutter up your code with extraneous
symbols such as braces. $does $perl $come $to $mind?


> Ok.. So I'm a heretic... I admit it!
>
> I have never really liked the C language, it seems to me that it has a
> habit of making ANY idiot think he/she can be a coder.  C is an easy

That's perl IMO.


> language to learn but to be a good C coder takes years of hard study
> and a TRUE artistic flair for programming.  This means that 99% of all
> C code is JUNK code.
>
> Before you all go running for your 1911 45 ACP's and 30-06's Linux is
> most defiantly in the 1% here, I just don't like the source format :P~

Then don't touch it.  Nobody said you have to like someone else's code.  Your
values and figures are yours.


> Comments and flames are welcome....

Comments and flames happily provided and my reply is also in the don't read
it if you don't like it category.

I like:

function()
{
    ...
}

do {
    /*
     * iterate over the entire structure and update the values if their
     * subtype is version 2
     */
    ...
} while();

if (x==IV)<tab>// action is inverse vector
    function();

if () {
    clearly_named_function();
    another_very_clearly_named_function();
}

/*
 * multi line comment
 * ...
 */


I mix C and C++ comment style as is appropriate.  It isn't going away and is
standard in the preprocessor now.

It's my code :)

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
