Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267060AbUBMPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267059AbUBMPi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:38:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8151 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267060AbUBMPhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:37:12 -0500
Date: Fri, 13 Feb 2004 15:39:36 +0000
From: Joe Thornber <thornber@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Joe Thornber <thornber@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: dm core patches
Message-ID: <20040213153936.GF15736@reti>
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti> <20040213151213.GR21298@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213151213.GR21298@marowsky-bree.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 04:12:14PM +0100, Lars Marowsky-Bree wrote:
> On 2004-02-12T20:13:40,
>    Joe Thornber <thornber@redhat.com> said:
> 
> > I think the main concern now is over the testing of paths.  Sending an
> > io down an inactive path can be very expensive for some hardware
> > configurations.  So I'm considering changing a couple of things:
> > 
> > - Only ever send io to 1 priority group at a time (even test ios).
> >   To test the lower priority groups we'd have to periodically switch to
> >   them and use them for a bit for both test io and proper io.
> 
> You are missing the obvious answer:
> 
> - Periodically checking paths is a user-space issue and doesn't belong
>   into the kernel. User-space gets to handle this policy.

Yes, that is obvious, I had wanted to do failback automatically.  But
pushing it to userland does allow people to write hardware specific
tests.  I'll try it and see what people think.

Thanks,

- Joe
