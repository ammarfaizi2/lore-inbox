Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVEDVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVEDVJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVEDVJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:09:44 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:21228 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261673AbVEDVGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:06:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GIgkcP05Wj4VUOyGOSKmNvGEWANQbslVvterL8fuIy0ADzLOHvI1Rs8YdyOwLWLEiNgmMwQ4U/yNZK0RO0FS7/A1fz3m0JfyRXswyv8pRJOBI5dmWfQ9YyJIRZsbsBz2l6Q35mir5KhIZVd/Yzh0nd2OqmoRAXTZ9v+qWySeFB0=
Message-ID: <81b0412b0505041406297427ba@mail.gmail.com>
Date: Wed, 4 May 2005 23:06:09 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: "Richard B. Johnson" <linux-os@analogic.com>,
       Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
In-Reply-To: <20050504191604.GA29730@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4279084C.9030908@free.fr>
	 <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
	 <20050504191604.GA29730@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/05, Daniel Jacobowitz <dan@debian.org> wrote:
> On Wed, May 04, 2005 at 02:16:24PM -0400, Richard B. Johnson wrote:
> > The kernel doesn't do SIGSTOP or SIGCONT. Within init, there is
> > a SIGSTOP and SIGCONT handler. These can be inherited by others
> > unless changed, perhaps by a 'C' runtime library. Basically,
> > the SIGSTOP handler executes pause() until the SIGCONT signal
> > is received.
> >
> > Any delay in stopping is the time necessary for the signal to
> > be delivered. It is possible that the section of code that
> > contains the STOP/CONT handler was paged out and needs to be
> > paged in before the signal can be delivered.
> >
> > You might quicken this up by installing your own handler for
> > SIGSTOP and SIGCONT....
> 
> I don't know what RTOSes you've been working with recently, but none of
> the above is true for Linux.  I don't think it ever has been.
> 

I don't even think it was true for anything. It's his usual way of
saying things.
