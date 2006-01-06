Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752195AbWAFHAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbWAFHAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbWAFHAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:00:44 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:10412 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750864AbWAFHAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:00:44 -0500
Date: Thu, 5 Jan 2006 23:00:19 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Dave Jones <davej@redhat.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
In-Reply-To: <20060106053609.GB32105@redhat.com>
Message-ID: <Pine.LNX.4.62.0601052253450.1708@qynat.qvtvafvgr.pbz>
References: <E1EuPZg-0008Kw-00@calista.inka.de> <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz> <20060106053609.GB32105@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Dave Jones wrote:

> On Thu, Jan 05, 2006 at 05:28:59PM -0800, David Lang wrote:
> > On Thu, 5 Jan 2006, Jan Engelhardt wrote:
> >
> > >Also note that the kernel generates a lot of noise^W text - if now the
> > >start scripts from $YOUR_FAVORITE_DISTRO also fill up, I can barely reach
> > >the top of the kernel when it says
> > > Linux version 2.6.15 (jengelh@gwdg-wb04.gwdg.de) (gcc version 4.0.2
> > > 20050901 (prerelease) (SUSE Linux)) #1 Tue Jan 3 09:21:27 CET 2006
> >
> > enable a few different types of encryption and you have to enlarge the
> > buffer (by quite a bit). the fact that all the encryption tests print
> > several lines each out and can't be turned off (short of a quiet boot
> > where you loose everything) is one of the more annoying things to me right
> > now.
> >
> > this large boot message issue also slows your boot significantly if you
> > have a fast box that has a serial console, it takes a long time to dump
> > all that info out the serial port.
>
> So disable CONFIG_CRYPTO_TEST. There's no reason to test this stuff every boot.
>

I've looked for such a config option and not found it in menuconfig. I'll 
take another look.

Ok, I found it. the help isn't clear about exactly what this does. Adding 
a blurb that you probably want it off unless you are developeing a crypto 
module, or that it's intended as a debugging tool would help clarify it.

Thanks.

   David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

