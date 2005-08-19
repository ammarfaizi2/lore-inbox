Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVHSORf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVHSORf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 10:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHSORf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 10:17:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39587 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964943AbVHSORe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 10:17:34 -0400
Date: Fri, 19 Aug 2005 15:20:26 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: vandrove@vc.cvut.cz, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 12:14:48PM +0100, Anton Altaparmakov wrote:
> Hi,
> 
> There is a bug somewhere in 2.6.11.4 and I can't figure out where it is.
> I assume it is present in older and newer kernels, too as the related
> code hasn't changed much AFAICS and googling for "Bad page state"
> returns rather a lot of hits relating to both older (up to 2.5.70!) and
> newer kernels...
> 
> Note: PLEASE do not stop reading because you read ncpfs below as I am
> pretty sure it is not ncpfs related!  And looking at google a lot of
> people have reported such similar problems since 2.5.70 or so and they
> were all told to go away as they have bad ram.  That is impossible
> because this happens on well over 600 workstations and several servers
> 100% reproducible.  Many different types of hardware, different makes,
> difference age, all running smp kernels even if single cpu.  You can't
> tell me they all have bad ram.  Windows works fine and Linux works fine
> except for that one specific problem which is 100% reproducible...
> 
> The bug only appears, but it appears 100% reproducibly when a cross
> volume symlink on ncpfs is accessed using nautilus under gnome.  I.e.
> double click on a cross volume symlink on ncpfs in nautilus and the
> machine locks up solid.

Ugh...  Could you at least tell what does nautilus attempt to do at that
point?  Something that wouldn't show up with simple ls -l <symlink> or
cat <symlink> >/dev/null, judging by the above, but what?
