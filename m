Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRHCOPd>; Fri, 3 Aug 2001 10:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbRHCOPV>; Fri, 3 Aug 2001 10:15:21 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:37899 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269134AbRHCOPD>; Fri, 3 Aug 2001 10:15:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Date: Fri, 3 Aug 2001 16:08:20 +0200
X-Mailer: KMail [version 1.2]
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080219261601.00440@starship> <20010803100633.Z12470@redhat.com>
In-Reply-To: <20010803100633.Z12470@redhat.com>
MIME-Version: 1.0
Message-Id: <01080316082001.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 11:06, Stephen C. Tweedie wrote:
> Hi,
>
> On Thu, Aug 02, 2001 at 07:26:16PM +0200, Daniel Phillips wrote:
> > I believe you've summarized the SUS requirements very well.  Apart
> > from legalistic arguments,
>
> Umm, this is a specification.  It is *supposed* to be interpreted
> legalistically!

I'm saying that, when the intent is clear as it is in this case then 
trying to find loopholes in the form of expression is not useful.  
Better to argue that SUS is wrong than to pretend it didn't say what it 
did.

> > SUS quite clearly states that fsync should
> > not return until you are sure of having recorded not only the
> > file's data, but the access path to it.  I interpret this as being
> > able to "access the file by its name", and being able to guess by
> > looking in lost+found doesn't count.
>
> But that is just an interpretation.  There's nothing in the spec
> which forces that interpretation.

Well, look at the name "lost+found".  It's lost, maybe we found the 
data but the name is gone for good.  On the other hand, if we start 
with the same on-disk state that fsck had before creating the 
lost+found, but use a journal to recover the name, it *does* count 
because we have a deterministic mechanism for making fsync's promise 
come true.

> fsync forces the data to disk.  There may be one or more pathnames
> which the application also relies on, and if the application does
> care about those, the application will have to ensure that they are
> synced too.
>
> Look, I agree that your interpretation is useful.  It's just not an
> unambiguous requirement of the spec.

OK, fine, this damn English language and all that.  Do we agree that 
"access" means "be able to open by name"?

--
Daniel
