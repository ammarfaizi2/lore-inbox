Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWAVXMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWAVXMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 18:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWAVXMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 18:12:37 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:41073 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964785AbWAVXMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 18:12:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KOcJoXCANIpxv95RRk70AcBBbLQmtq4waW0HTcf5Z7pVweZv6OJVIj+VhShZ343qFax262AsIOfaJjp1uA5Ek45fWXFm37ULYMO5Fo7FUkrT9kYea8SXVdQcpOsJVoM5oVuhCmTyMQiE7T+J/OvJMHYk+H5+59h2GxoaApwr8/8=
From: Patrick McFarland <diablod3@gmail.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16-rc1-g3ee68c4: powernow-k7: -ENODEV
Date: Sun, 22 Jan 2006 18:12:30 -0500
User-Agent: KMail/1.9.1
Cc: Thomas Meyer <thomas.mey@web.de>, linux-kernel@vger.kernel.org
References: <1137862645.8665.11.camel@hotzenplotz.treehouse> <20060122051929.GA6093@redhat.com>
In-Reply-To: <20060122051929.GA6093@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601221812.30580.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 00:19, Dave Jones wrote:
> On Sat, Jan 21, 2006 at 05:57:25PM +0100, Thomas Meyer wrote:
>  > I switched my config from up to smp support with 2 processors.
>  >
>  > trying to modprobe powernow-k7 gives me now:
>  > "
>  > cpufreq-core: trying to register driver powernow-k7
>  > cpufreq-core: adding CPU 0
>  > cpufreq-core: initialization failed
>  > cpufreq-core: no CPU initialized for driver powernow-k7
>  > cpufreq-core: unregistering CPU 0
>  > "
>
> powernow-k7 doesn't support SMP.
> The ubuntu folks tried to make single CPUs work with a SMP kernel,
> but it still didn't work out aparently.  The only K7's with powernow
> aren't SMP capable anyway iirc.

ATM, theres a work around for that. -386 kernels don't have smp enabled, and 
powernow-k7 works fine for them. So if you're using Ubuntu, and absolutely 
need powernow-k7 to work, don't use the -k7 kernel, use the -386 kernel.

https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/26713

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

