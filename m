Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWIALf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWIALf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWIALf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:35:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:1330 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751488AbWIALf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:35:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pNh/dlGF9ZOcDS+vXdeYt3Qf658ViZUfIF+PTGEF9GY+OjlBmkDA93nd8Yej5wzx0fUvi1fmT2R1V5zaXqPYy/up0gbuF6hblkvVG94sGGCa3ECQoJvHC2S+W5AgnUurIi4IvaF72RMkvBp0HN4L3Xcmz7JaSjfwgPjBUmHfdKc=
Message-ID: <9a8748490609010435k6b327237ve6a23ddcaa0f4065@mail.gmail.com>
Date: Fri, 1 Sep 2006 13:35:20 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: Re: Unable to halt or reboot due to - unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       waltje@uwalt.nl.mugnet.org, ross.biro@gmail.com, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org
In-Reply-To: <9a8748490609010351kd8f0d40ud3509e2f3eaa89ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609010259l7c42ca88tbcc87410a770b48c@mail.gmail.com>
	 <E1GJ6St-0004Te-00@gondolin.me.apana.org.au>
	 <9a8748490609010351kd8f0d40ud3509e2f3eaa89ac@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 01/09/06, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > >
> > > I've just encountered the problem on a different server with an
> > > identical vlan setup. That server is running 2.6.13.4
> >
> > Do you have a simple recipe to reproduce this? Ideally it'd be a
> > script that anyone can execute in a freshly booted system that
> > exhibits the problem.
> >
> Well, the first server I saw this on only had a base install of debian
> stable on it, then I replaced the kernel, configured the vlan
> interface in /etc/network/interfaces typed 'reboot' and it failed -
> and it seems to fail reliably on reboot every time.
>
Ok, I've done some more testing and it seems, unfortunately, that I
can't trigger the problem reliably. I guess I was just "lucky" with my
first few reboots.
It now seems that uptime and/or amount of data that has flowed over
the vlan interface impacts the probability of hitting the problem.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
