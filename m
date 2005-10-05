Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVJENIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVJENIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVJENIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:08:18 -0400
Received: from web30311.mail.mud.yahoo.com ([68.142.201.229]:47727 "HELO
	web30311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965163AbVJENIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:08:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1SsL+ccvdhlKqJcN+pe7lXbJaSqLJxg0HJA47sXVX7Mn5LL8vlTOhyB2vWFTWt9LdiDOhpBObIjBonJrMRdipDAF95qlZWg5mK+/Pus3EcfB+Px4U6c7SVYYFWp6muNuwGJmarByzxbJv4quxbgm6cXt8GCcvlpcHoO0peKNXUw=  ;
Message-ID: <20051005130817.98406.qmail@web30311.mail.mud.yahoo.com>
Date: Wed, 5 Oct 2005 06:08:17 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051005112558.GC18448@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A single thread writing at 30MB/s is still not on par
with 3ware's specs.

I see that you're also running RAID5 and in this case
3ware did report bad write performance on RAID5 and
that was fixed with recent firmwares. 

The latest linux driver off their website also
includes the latest firmware inside it and flashes the
card upon load, make sure to use that.

I'm getting a little over 50MB/s when writing to my
RAID volume when completely idle, there's no reason
why you should get less.

As for read performance, nothing helps with many
concurrent reads, what I get is simply aweful
performance no matter what I do.

I'll let you guys know once I try JBOD (as soon as all
the data is moved away).

According to Ville answering me privately:

> Unfortunately, it's not limited to just that
firmware version or kernel version or driver version.
I've tried several firmwares, 2.4.x and 2.6.x kernels
and driver version - no salvage.

I do agree, which leads me to believe this is
something very specific with the RAID controller
itself or its firmware.

Maybe something is so badly designed in this
controller that it can't physically do better than
that ? Anyone has experience with this controller and
its performance on windoze?

Can someone in the know give us some input ?

Thanks

--- "Dr. David Alan Gilbert" <dave@treblig.org> wrote:

> > Something is very wrong with this card / driver /
> > firmware and or kernel combination,  hopefully
> someone
> > can help out.
> 
> I think I have to agree; see my post from:
> 
>
http://marc.theaimsgroup.com/?l=linux-kernel&m=112282837926689&w=2
> 
> I've got about 30MB/s from a single threaded version
> of my
> backup code - which seems rather on the low side for
> a modern RAID-5; with multiple writers I was seeing
> sub-5MB/s
> but that might be fair if it is seeking everywhere.
> 
> I'd be interested to hear how your experiments with
> jbod'ing them
> go.
> 
> Dave
> --
>  -----Open up your eyes, open up your mind, open up
> your code -------   
> / Dr. David Alan Gilbert    | Running GNU/Linux on
> Alpha,68K| Happy  \ 
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC
> & HPPA | In Hex /
>  \ _________________________|_____
> http://www.treblig.org   |_______/
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
