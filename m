Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261255AbRERRdS>; Fri, 18 May 2001 13:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbRERRdI>; Fri, 18 May 2001 13:33:08 -0400
Received: from quattro.sventech.com ([205.252.248.110]:9993 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S261255AbRERRcw>; Fri, 18 May 2001 13:32:52 -0400
Date: Fri, 18 May 2001 13:32:51 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010518133250.O32405@sventech.com>
In-Reply-To: <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com> <20010517102029.A44@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010517102029.A44@toy.ucw.cz>; from Pavel Machek on Thu, May 17, 2001 at 10:20:30AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001, Pavel Machek <pavel@suse.cz> wrote:
> > > But no, I don't actually like sockets all that much myself. They are hard
> > > to use from scripts, and many more people are familiar with open/close and
> > > read/write.
> > 
> > Agreed.
> > 
> > It would be nice to use open/close/read/write for control and bulk and
> > sockets for interrupt and isochronous.
> 
> What makes interrupt so different? Last time I checked int pipes were very
> similar to bulk pipes... Do you care about "packet boundaries"? You can
> somehow emulate with read, too...

We probably could. It would have interesting semantics however. We would
have to have an ioctl or something else to specify period, and if it's
one shot, etc.

We could probably shoehorn isochronous semantics onto read/write as
well, but I don't want to begin to think how ugly that'll be.

The reason I don't favor the read/write idea for interrupt and
isochronous are the fact that they are so different. We could shoehorn
the semantics onto it, but we'd just be moving the problem from one
place to somewhere else.

A completely ioctl solution would work better in that case since it's
cleaner. The only problem would be the fact it's called ioctl.

JE

