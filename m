Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131574AbQLVTOA>; Fri, 22 Dec 2000 14:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131803AbQLVTNt>; Fri, 22 Dec 2000 14:13:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:41476 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131574AbQLVTNl>; Fri, 22 Dec 2000 14:13:41 -0500
Date: Fri, 22 Dec 2000 11:35:30 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Cc: jmerkey@timpanogas.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222113530.A14479@vger.timpanogas.org>
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl> <20001222111105.B14232@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001222111105.B14232@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Dec 22, 2000 at 11:11:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 11:11:05AM -0700, Jeff V. Merkey wrote:
> On Fri, Dec 22, 2000 at 09:39:28AM +0100, Pauline Middelink wrote:
> > On Thu, 21 Dec 2000 around 15:53:39 -0700, Jeff V. Merkey wrote:
> 

Pauline/Alan,

I have been studying the SCI code and I think I may have a workaround that
won't need the patch, but it will require pinning large chunks of memory 
with the existing __get_free_pages() functions.  I will need to make the 
changes and test them.   This change will require significant testing.  I will
ping you guys if I have questions.  If we can reach a compromise on the 
bigphysarea patch, it would be great, but absent this, I will be looking
at this alternate solution.

The real question is how to guarantee that these pages will be contiguous
in memory.  The slab allocator may also work, but I think there are size
constraints on how much I can get in one pass.

:-)

Jeff

> 
> 
> 
> > -- 
> > GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
> > For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
