Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318409AbSGSATp>; Thu, 18 Jul 2002 20:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318411AbSGSATo>; Thu, 18 Jul 2002 20:19:44 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19077 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S318409AbSGSATo>; Thu, 18 Jul 2002 20:19:44 -0400
Date: Thu, 18 Jul 2002 18:22:35 -0600
Message-Id: <200207190022.g6J0MZr28197@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Keith Owens <kaos@ocs.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'devfs@oss.sgi.com'" <devfs@oss.sgi.com>
Subject: Re: Inexplicable disk activity trying to load modules on devfs 
In-Reply-To: <19231.1025128989@ocs3.intra.ocs.com.au>
References: <200206260338.g5Q3cmc19214@mobilix.ras.ucalgary.ca>
	<19231.1025128989@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> On Tue, 25 Jun 2002 23:38:48 -0400, 
> Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
> >Daniel Jacobowitz writes:
> >> For the curious, the reason is that modprobe writes even failed
> >> attempts to a log in /var/log/ksymoops, and calls fdatasync() on
> >> that file afterwards.  There is no way to disable this without
> >> removing that directory, as a design decision.  I don't personally
> >> see the point in logging attempts which fail because there is no
> >> driver...
> >
> >Sounds like the behaviour of modprobe needs to be fixed.
> 
> People wanted to know what was invoking modprobe and with what
> parameters, especially for failed attempts.  The call to fdatasync()
> is to "ensure" that the log data hits the disk _before_ the module
> is loaded, otherwise debugging data is lost if the module init
> routine oopses.

Then there needs to be a way of enabling/disabling this. Maybe a
run-time config option?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
