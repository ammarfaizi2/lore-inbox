Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTIVQem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTIVQem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:34:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:12810 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263233AbTIVQeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:34:36 -0400
Date: Mon, 22 Sep 2003 18:34:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, linux-kernel@vger.kernel.org
Subject: Re: unknown symbols loading modules under 2.6.x
Message-ID: <20030922163432.GA3208@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Kirk Reiser <kirk@braille.uwo.ca>, linux-kernel@vger.kernel.org
References: <E1A1TE1-00075s-00@speech.braille.uwo.ca> <20030922091800.3b2532ec.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922091800.3b2532ec.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 09:18:00AM -0700, Randy.Dunlap wrote:
> On Mon, 22 Sep 2003 12:07:45 -0400 Kirk Reiser <kirk@braille.uwo.ca> wrote:
> 
> | Hello Everyone:  I have been trying to hunt down the answer to
> | aproblem I am having attempting to load my modules under the 2.6.x
> | kernels.  They load just fine under the 2.4.x kernels.  Have there
> | been changes which need to be made to get symbols found with modprobe
> | other than the EXPORT_SYMBOL() macro?  The symbols show up in the
> | modules.symbols file created by depmod.  They appear to reference the
> | correct loadable module.  The loadable module these symbols are
> | exported in however is comprised of two separate .o files during
> | compile.  I am not sure whether that has anything to do with it or
> | not.
> | 
> | If someone could give me an idea what to read to solve this I'd
> | appreciate it.
> 
> Make sure that you have the current version of module-init-tools
> installed from http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> and that scripts are using them (ie, check PATH).

Also make sure that you use kbuild when compiling your module.
See Documentation/modules.txt (or Documentation/kbuild/modules.txt
in BK-latest).

	Sam
