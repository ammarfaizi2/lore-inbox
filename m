Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUBPUjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265896AbUBPUjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:39:05 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:35191 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265843AbUBPUjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:39:03 -0500
Date: Mon, 16 Feb 2004 21:54:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: some combinations of make targets do not work anymore
Message-ID: <20040216205431.GB2977@mars.ravnborg.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040128180111.GA23021@suse.de> <20040128194549.GB2695@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128194549.GB2695@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 08:45:49PM +0100, Sam Ravnborg wrote:
> On Wed, Jan 28, 2004 at 07:01:11PM +0100, Olaf Hering wrote:
> > 
> > Stuff like that used to work with 2.4 kernels, 2.6.2-rc2-mm2 runs make
> > oldconfig and depmod, but 'all' and 'modules_install' is not executed.
> > Bug or feature? target is ppc32.
> 
> Unexpected to say it. I have noticed some time ago, but since noone complained...
> I will take a look.

Hi Olaf.

I took a look at this. The logic that I introduced when moving the *config
target to scripts/kconfig/Makefile had this side-effect.
To fix it I have to do too much changes to the top-level Makefile - and I do
not see such a big benefit here.

So unless someone comes with good arguments I will let the current non-optimal
behaviour stay.

	Sam
