Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289382AbSAODNL>; Mon, 14 Jan 2002 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289380AbSAODMw>; Mon, 14 Jan 2002 22:12:52 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:51718 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S289376AbSAODMj>; Mon, 14 Jan 2002 22:12:39 -0500
Date: Tue, 15 Jan 2002 02:07:58 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115020758.GA59418@compsoc.man.ac.uk>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020115013954.GB3814@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115013954.GB3814@cpe-24-221-152-185.az.sprintbbd.net>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16QIyy-00053X-00*rc/PfNvedyw* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:39:54PM -0700, Tom Rini wrote:

> Wrong.  She needs to compile a new module for her kernel.  What might be
> useful is some automagic tool that will find the vendor-provided kernel
> source tree and config (which is usually /boot/config-`uname -r`, but
> still findable anyhow)

autoconf code already exists for this, it's a non-problem. Note they must use
the config in the header file of the vendor-provided kernel source tree, not
/boot/config-`uname -r`

There are two cases:

1) the vendor source tree is installed and set up with the right config -> use header file

2) it's installed and the config has changed. -> use header file

I don't see a point in ever looking at /boot/config-`uname -r` instead of
the source tree, given that we must compile against a tree configured like the
eventual running kernel anyway.

regards
john

-- 
"Now why did you have to go and mess up the child's head, so you can get another gold waterbed ?
 You fake-hair contact-wearing liposuction carnival exhibit, listen to my rhyme ..."
