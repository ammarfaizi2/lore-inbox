Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269365AbRHCJH0>; Fri, 3 Aug 2001 05:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269372AbRHCJHQ>; Fri, 3 Aug 2001 05:07:16 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:54001 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S269365AbRHCJHK>; Fri, 3 Aug 2001 05:07:10 -0400
Date: Fri, 3 Aug 2001 10:06:33 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803100633.Z12470@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080219261601.00440@starship>; from phillips@bonn-fries.net on Thu, Aug 02, 2001 at 07:26:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 02, 2001 at 07:26:16PM +0200, Daniel Phillips wrote:

> I believed you've summarized the SUS requirements very well.  Apart 
> from legalistic arguments,

Umm, this is a specification.  It is *supposed* to be interpreted
legalistically!

> SUS quite clearly states that fsync should 
> not return until you are sure of having recorded not only the file's 
> data, but the access path to it.  I interpret this as being able to 
> "access the file by its name", and being able to guess by looking in 
> lost+found doesn't count.

But that is just an interpretation.  There's nothing in the spec which
forces that interpretation.

fsync forces the data to disk.  There may be one or more pathnames
which the application also relies on, and if the application does care
about those, the application will have to ensure that they are synced
too.

Look, I agree that your interpretation is useful.  It's just not an
unambiguous requirement of the spec.

Cheers,
 Stephen
