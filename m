Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUIDMfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUIDMfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUIDMfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:35:19 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:44249 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267793AbUIDMfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:35:07 -0400
Message-ID: <4139B675.9030202@tungstengraphics.com>
Date: Sat, 04 Sep 2004 13:35:01 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904124658.A14628@infradead.org> <Pine.LNX.4.58.0409041253390.25475@skynet> <20040904121039.GB26419@redhat.com>
In-Reply-To: <20040904121039.GB26419@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Sep 04, 2004 at 01:04:17PM +0100, Dave Airlie wrote:
> 
>  > releases, I would like to give those people a chance to use their graphics
>  > cards, and the snapshots are not the only way, Intel have i915 Linux
>  > drivers on their site from TG, they work on most kernels/distros, I get a
>  > machine with i915 install Debian go to Intels website and download their
>  > drivers, it all works, now why do I have to compile a kernel again?
> 
> Then a month later, Debian issues a kernel security errata.
> You download and install it, and your 3d stops working.
> (worse case, maybe even your 2d breaks).
> The 'download third party drivers' thing is not a silver bullet.
> It will screw end users over, just as equally as it claims to help them.

Dave,

There's no real disagreement that the best way to do things would be have 
everything come down nicely packaged from the distro vendor.  (Certainly with 
my TG hat on, that is how we'd like to see things work - it's obviously easier 
for us.)  Historically it just didn't work though, and even into the future, 
no matter what changes, I can still see a requirement for binary snapshots or 
downloadable drivers.

With the new LK "always stable" development model, one barrier to this ideal 
of fast distribution of drivers seems to have fallen.   This is perhaps the 
biggest change, and I admit the implications have only just started to sink in.

Dave Airlie taking a pro-active role as DRM maintainer is also a recent change 
- for a long time that code was a neglected corner of the XFree86 tree, now 
it's starting to look like a first-class project in its own right and is 
getting more of the attention it needs to beat it into shape.

The remaining question mark is the process of pushing the userspace drivers 
out.  I floated a proposal recently to loosely synchronize Xorg and Mesa 
release schedules which might help a little, but there is still a potentially 
long delay affecting the userspace parts of a driver in their progress to 
vendors & ultimately users.  Ultimately you're right that splitting that tree 
up & letting the parts evolve independently might address the problems there, 
though that's at least two X releases away.

In the meantime, though, downloadable binary drivers continue to be a useful 
testing aid for the DRI project (their original intent), and a convenient 
bandaid for working around a distribution channel which I think will probably 
be pretty slow for a year or more to come.

Keith
