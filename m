Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTH0Pw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263508AbTH0Pw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:52:28 -0400
Received: from village.ehouse.ru ([193.111.92.18]:27910 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263507AbTH0Pw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:52:26 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Wed, 27 Aug 2003 19:52:29 +0400
User-Agent: KMail/1.5
References: <1059871132.2302.33.camel@mars.goatskin.org> <200308032258.17450.rathamahata@php4.ru> <20030804000514.GY22824@waste.org>
In-Reply-To: <20030804000514.GY22824@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271952.29331.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 04:05, Matt Mackall wrote:
> On Sun, Aug 03, 2003 at 10:58:17PM +0400, Sergey S. Kostyliov wrote:
> > Hello Andrew,
> >
> > On Sunday 03 August 2003 05:04, Andrew Morton wrote:
> > > Shane Shrybman <shrybman@sympatico.ca> wrote:
> > > > One last thing, I have started seeing mysql database corruption
> > > > recently. I am not sure it is a kernel problem. And I don't know the
> > > > exact steps to reproduce it, but I think I started seeing it with
> > > > -test2-mm2. I haven't ever seen db corruption in the 8-12 months I
> > > > have being playing with mysql/php.
> > >
> > > hm, that's a worry.  No additional info available?
> >
> > I also suffer from this problem (I'm speaking about heavy InnoDB
> > corruption here), but with vanilla 2.6.0-test2. I can't blame
> > MySQL/InnoDB because there are a lot of MySQL boxes around of me with the
> > same (in fact the box wich failed is replication slave) or allmost the
> > same database setup. All other boxes (2.4 kernel) works fine up to now.
>
> All Linux kernels prior to 2.6.0-test2-mm3-1 would silently fail to
> complete fsync() and msync() operations if they encountered an I/O
> error, resulting in corruption. If a particular disk subsystem was
> producing these errors, the symptoms would likely be:
>
> - no error reported
> - no messages in logs
> - independent of kernel version, etc.
> - suddenly appear at some point in drive life
> - works flawlessly on other machines
>
> If you can reproduce this corruption, please try running against mm3-1
> and seeing if it reports problems (both to fsync and in logs).

I've just got another one InnoDB crash with 2.6.0-test4.
As in previous case there was no messages in kernel log.
You can find mysql error log here.
http://sysadminday.org.ru/linux-2.6.0-test4_InnoDB_crash

It's a development server, so this isn't a big problem.
I do understand that this can easily be a hardware problem,
but the kernel silence is really sad in such case.
Memory is fine (at least according to memtest 3.0).

Any hints will be appreciated.

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
