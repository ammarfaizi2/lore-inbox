Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWCHTF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWCHTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWCHTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:05:26 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:20702 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbWCHTFZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:05:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B6OnetdjuDauXwhGYa5Rlk9YLVHpBxKPmcWTXxh4UIkjb51IIFW6Val0wbYE44XlGiM4hECrk50bDFKpFi32xkTy174JlF3C2zP4ZkPxw2ngUqdT9wU+WGJBpX6XZgCf0Dm5mOGVXM42VRu6aj6Frst3q9mcfqpoxj6GavJ63/M=
Message-ID: <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
Date: Wed, 8 Mar 2006 20:05:24 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ben Collins" <bcollins@ubuntu.com>
Subject: Re: [Updated]: How to become a kernel driver maintainer
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <1141841013.24202.194.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136736455.24378.3.camel@grayson>
	 <1136756756.1043.20.camel@grayson>
	 <1136792769.2936.13.camel@laptopd505.fenrus.org>
	 <1136813649.1043.30.camel@grayson>
	 <1136842100.2936.34.camel@laptopd505.fenrus.org>
	 <1141841013.24202.194.camel@grayson>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Ben Collins <bcollins@ubuntu.com> wrote:

Nice work Ben. A few comments and suggestions below.

> authors really don't see the benefit of having their code in the main
> kernel. Some even see it as giving up control of their code. This is
> simply not the case, and then end result is always beneficial to users

s/and then end result/and the end result /


>
> What should I do to prepare for code submission?
> ------------------------------------------------
>
> First you need to inspect your code and make sure it meets criteria for
> inclusion. Read Documentation/CodingStyle for help on proper coding
> format
> (indentation, comment style, etc). It is strongly suggested that your
> driver builds cleanly when checked by the "sparse" tool. You will

suggested text:
  driver builds cleanly without warnings from the compiler or the "sparse" tool.


>
>   - When creating the Kconfig entries be sure to keep in mind the
> criteria
>     for the driver to be build. For example, a wireless network driver
> may
>     need to "depend on NET && IEEE80211". Also, if you driver is
> specific
>     to a certain architecture, be sure the Kconfig entry reflects this.
> DO
>     NOT force your driver to a specific architecture simply because the
>     driver is not written portably.
>
Suggested addition:
  Also make sure you provide useful help text for every entry you add
to Kconfig so that users of your driver will be able to read about
what it does, what hardware it supports and perhaps find a reference
to more extensive documentation.


> Lastly, you'll need to create an entry in the MAINTAINERS file. It
> should
> reference you or the team responsible for the code being submitted (this
> should be the same person/team submitting the code).
>
Suggested addition:
  Optionally you may also want to add an entry to the CREDITS file.


> not familiar with the code or it's purpose are left with keeping it
> compiling and working. So the code needs to be readable, and easily
> modified.
>

s/modified/modifiable/


> Secondly, the code review helps you to make your driver better. The
> folks

s/folks/people/  ???


> There are times where changes to your driver may happen that are not the
> API type of changes described above. A user of your driver may submit a
> patch directly to Linus to fix an obvious bug in the code. Sometimes
> these
> trivial and obvious patches will be accepted without feedback from the
> driver maintainer. Don't take this personally. We're all in this
> together.
> Just pick up the change and keep in sync with it. If you think the
> change
> was incorrect, try to find the mailing list thread or log comments
> regarding the change to see what was going on. Then email the patch
> author
> about the change to start discussion.
>
Perhaps add a bit of text here about integrating patches send to you,
as maintainer of the driver, by random people.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
