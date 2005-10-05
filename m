Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVJENjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVJENjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVJENjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:39:07 -0400
Received: from web30312.mail.mud.yahoo.com ([68.142.201.230]:2904 "HELO
	web30312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965147AbVJENjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:39:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UvoQIs4jAh/xX0eb2bp1Io3s50NegK3En6m6gj3q8kxAZnlyA5adNSvxmIo0aLoQNo1AaJoMJcAGaJWDUP+kWsSsx5leu8YYEnhwOar2ghga7/VhR+5bw78lwKlO6FXRXPQmMvbn9kKfdhAxG5EZ2YAH6Cyp/8nAwMPPc/6PXOk=  ;
Message-ID: <20051005133906.90687.qmail@web30312.mail.mud.yahoo.com>
Date: Wed, 5 Oct 2005 06:39:06 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051005131804.GD18448@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> 
> I've got driver/firmware that is about 2months old
> that
> certainly helped; prior to that I was getting card
> timeouts (although I also upgraded the e1000 driver
> at the same time so it might have been that rather
> than the 3ware that helped).

Two months old might be too old, make sure you have at
least 9.2.1.1

> (Note: I don't expect a driver to perform a
> dangerous
> operation like firmware flashing on boot!)

I believe they are writing to NVRAM or similar so that
makes it much less risky, otherwise they wouldn't have
to write it on each load ... or I might be wrong and
they do it once, not sure.
  
> > I'm getting a little over 50MB/s when writing to
> my
> > RAID volume when completely idle, there's no
> reason
> > why you should get less.
> 
> Well my ~30MB/s is sucking over gig ether and
> writing
> in 10MB chunks; but still 50MB/s for RAID5 feels
> like
> it sucks.

Yes, that's terrible.

Reading the release notes for the latest one, 9.3.0
that also supports their very latest controller,
9550SX,  I get the feeling that write performance is
something of an on-going issue with this family of
controllers even though they disguise it in this
latest  driver version as a tweak in write
performance.

Another thing, the BBU (battery backup unit) that you
are using was also a can of worms for them so this
makes it even more important for you to upgrade to the
very latest version ,they seem to be having ongoing
issues with that one.

Good luck to us all.


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
