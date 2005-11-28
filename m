Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVK1QVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVK1QVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVK1QVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:21:14 -0500
Received: from fmr20.intel.com ([134.134.136.19]:22709 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751267AbVK1QVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:21:14 -0500
From: mgross <mgross@linux.intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: capturing oopses
Date: Mon, 28 Nov 2005 08:20:02 -0800
User-Agent: KMail/1.7.1
Cc: vherva@vianova.fi, bunk@stusta.de, folkert@vanheusden.com,
       linux-kernel@vger.kernel.org
References: <20051122130754.GL32512@vanheusden.com> <20051126193358.GF22255@vianova.fi> <20051127204132.2b0d7406.rdunlap@xenotime.net>
In-Reply-To: <20051127204132.2b0d7406.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511280820.02473.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 November 2005 20:41, Randy.Dunlap wrote:
> On Sat, 26 Nov 2005 21:33:58 +0200 Ville Herva wrote:
> > On Sat, Nov 26, 2005 at 04:56:56PM +0100, you [Adrian Bunk] wrote:
> > > On Tue, Nov 22, 2005 at 02:07:54PM +0100, Folkert van Heusden wrote:
> > > > Hi,
> > >
> > > Hi Folkert,
> > >
> > > > My 2.6.14 system occasionally crashes; gives a kernel panic. Of
> > > > course I would like to report it. Now the system locks up hard so I
> > > > can't copy the stacktrace. The crash dump patches mentioned in
> > > > oops-tracing.txt all don't work for 2.6.14 it seems. So: what should
> > > > I do? Get my digicam and take a picture of the display?
> > >
> > > yes, digicams have become a common tool for reporting Oops'es.
> >
> > Speaking of which, does anybody know a feasible (as in "not too much
> > harder than manually typing it in manually") way to OCR characters from
> > vga text mode screen captures - or even digican shots?
> >
> > The vga text mode captures are from a remote administration interface
> > (such as HP RILOE or vmware gsx console) so they are pixel perfect and
> > OCR should be doable. The digican shots on the other hand... Well at
> > least it would have hack value :).
> >
> > (My personal opinion is that Linus' unwillingness to include anything
> > like kmsgdump (http://www.xenotime.net/linux/kmsgdump/) is somewhat
> > unfortunate.)
>
> BTW, status of that:  it needs a little work to be more reliable.
> (It hangs sometimes when switching from protected to real mode.)
> I'm hoping that some of the APIC/IOAPIC/PIC patches that are being
> done for kdump will also help kmsgdump.  I'll be working more on it
> in the next few weeks/months.
>
> so yes, when it's working, it's very useful IMO.
>

You know some platforms that perserve the memory above some addresses across 
warm boots.  For such platforms, one could reserve a buffer in that area can 
copy the sys log buffer to it on panic along with a bit pattern that could be 
searched for upon the next boot.

Additionally some platforms have flash parts that could be used as a 
persistant store for such data in the same manner.  I've done this on an 
XScale platform using an ancient (2.4.10) kernel.  I've always thought it 
would be a handy thing for the newer kernels for PC's, if we could come up 
with a semi-platform independent way of identifying a few pages that would 
survive a warm boot.

--mgross
