Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273900AbRIXNHg>; Mon, 24 Sep 2001 09:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273897AbRIXNHZ>; Mon, 24 Sep 2001 09:07:25 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:14772 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273900AbRIXNHJ> convert rfc822-to-8bit; Mon, 24 Sep 2001 09:07:09 -0400
Subject: Re: __alloc_pages: 0-order allocation failed
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12 (Preview Release)
Date: 24 Sep 2001 08:13:42 +0000
Message-Id: <1001319223.4613.34.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Sep 2001 08:12:20 -0300, Marcelo Tosatti wrote:
> 
> 
> On Mon, 24 Sep 2001, Jacek [iso-8859-2] Pop³awski wrote:
> 
> > I just installed 2.4.10, and...
> > 
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > VM: killing process donkey_s
...

I'm getting a lot of this with 2.4.10 also.  At the time, I had KDM
running, but I was coming into the box over telnet and running the
latest released version of LTP.  The test it appeared to be on at the
time was a filesystem test called growfiles.  Nothing else was running
other than these things and standard system services.  The machine has
256 MB of ram, and 512 MB swap.  The order that things got killed in
were sadc, sar, kdm, X, in.telnetd, xinetd (ouch).


__alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c012b9b2
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
VM: killing process xinetd
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2

Thanks,
Paul Larson

