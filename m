Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRHCOx5>; Fri, 3 Aug 2001 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269234AbRHCOxs>; Fri, 3 Aug 2001 10:53:48 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:63217 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S269392AbRHCOxe>; Fri, 3 Aug 2001 10:53:34 -0400
Date: Fri, 3 Aug 2001 15:52:55 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803155255.X12470@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080219261601.00440@starship> <20010803100633.Z12470@redhat.com> <01080316082001.01827@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080316082001.01827@starship>; from phillips@bonn-fries.net on Fri, Aug 03, 2001 at 04:08:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 04:08:20PM +0200, Daniel Phillips wrote:

> I'm saying that, when the intent is clear as it is in this case then 
> trying to find loopholes in the form of expression is not useful. 

The intent is perfectly clear regarding the data.  It is totally
undefined regarding names. 
 
> Well, look at the name "lost+found".  It's lost, maybe we found the 
> data but the name is gone for good.

That's fine --- it satisfies the SUS requirements.

> On the other hand, if we start 
> with the same on-disk state that fsck had before creating the 
> lost+found, but use a journal to recover the name, it *does* count 
> because we have a deterministic mechanism for making fsync's promise 
> come true.

That's an implementation decision, not a comment on the spec.

> > Look, I agree that your interpretation is useful.  It's just not an
> > unambiguous requirement of the spec.
> 
> OK, fine, this damn English language and all that.  Do we agree that 
> "access" means "be able to open by name"?

The word "access" isn't used there in the spec, so it doesn't matter.
The spec only refers to "all file system information required to
retrieve the data."  Integrity of the data is the only thing
guaranteed, not integrity of the namespace.

Cheers,
 Stephen
