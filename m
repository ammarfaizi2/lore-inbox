Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWEWOb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWEWOb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWEWOb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:31:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4882 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750752AbWEWOb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:31:27 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andi Kleen <ak@suse.de>
Subject: Re: IA32 syscall 311 not implemented on x86_64
Date: Tue, 23 May 2006 17:30:58 +0300
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, dragoran <dragoran@feuerpokemon.de>,
       linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <20060521222831.GP8250@redhat.com> <200605220037.58286.ak@suse.de>
In-Reply-To: <200605220037.58286.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605231730.58616.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 01:37, Andi Kleen wrote:
> On Monday 22 May 2006 00:28, Dave Jones wrote:
> > On Mon, May 22, 2006 at 12:19:08AM +0200, Andi Kleen wrote:
> > 
> >  > >  > You make a good point.  In fact, given it's unthrottled, someone
> >  > >  > with too much time on their hands could easily fill up a /var
> >  > >  > just by calling unimplemented syscalls this way.
> >  > 
> >  > I never bought this argument because there are tons of printks in the kernel
> >  > that can be triggered by everybody.
> > 
> > Then they should also be either rate limited, or removed.
> 
> Yes let's remove all that kernel debugging support. It is totally useless
> for most users, isn't it?
> 
> Even if they are ratelimit you can still fill up /var.

If one has syslogd which does not rotate logs, [s]he gets what [s]he deserves.

There are two desirable properties of logs:
 (a) do not lose information (i.e. save entire log)
 (b) do not overflow log storage
and they are simply incompatible. You must pick one.

I took (b) and am a very happy user of daemontools' multilog ever since.
I never need to manually manage my logs again...
--
vda
