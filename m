Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265161AbRFUTrb>; Thu, 21 Jun 2001 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265162AbRFUTrL>; Thu, 21 Jun 2001 15:47:11 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:62855 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265161AbRFUTrJ>; Thu, 21 Jun 2001 15:47:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: stimits@idcomm.com
Subject: Idea: Patches-from-linus mailing list?  (Was Re: Alan Cox quote? (was: Re: accounting for threads))
Date: Thu, 21 Jun 2001 10:46:06 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <200106202120.f5KLKO5320707@saturn.cs.uml.edu> <0106201618550H.00776@localhost.localdomain> <3B31548A.5CD51796@idcomm.com>
In-Reply-To: <3B31548A.5CD51796@idcomm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01062110460607.00845@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 21:57, D. Stimits wrote:

> MySQL is just a sample. I mention it because it is quite easy to link a
> web server to. Imagine patch running on a large file that is a
> conglomeration of 50 small patches; it could easily summarize this, and
> storing it through MySQL adds a lot of increased web flexibility (such
> as searching and sorting). It is, however, just one example of a way to
> make "patch" become autodocumenting.

Not so much patch as a wrapper around patch.  That's a good idea.  A small 
perl script would do it...

Right now, Linus makes a big file by appending mail messages to it.  His 
mailer is, in theory, putting mail headers at the start of each of these 
messages (from, to, subject, and all that).  At the end of the day, he feeds 
that big file to patch and it applies all the patches he's read through and 
decided he likes.

It should  be fairly easy to make a wrapper around patch that splits out a 
single mail message, feeds it to patch, and on some measurement of "success" 
forwards it to an otherwise read-only mailing list.  (Which can then have a 
database based archiver subscribed to that list, if necessary.)

If Linus used such a beast, we could get the actual mail messages Linus is 
applying patches from, as they're applied.  Including any human readable 
documentation in them that patch itself would discard.  No more asking "did 
patch such and such get applied, when, who was it from"...

And we get the extra patch granularity Linus himself is so keen on.  Instead 
of waiting for our weekly pre2-pre3 100k patch, we could follow the 
individual ones as logically grouped changes, with subject lines saying what 
the patch is about and everything.

And the people hankering to make a CVS tree out of LInux kernel development 
would then have a much better checkin granularity to work with. :)

The main thing, though, is that done right, it's no extra burden on Linus.  
(Which is kind of important if we ever hope to get him to use it. :)

Sound like an idea to anybody else?

Rob
