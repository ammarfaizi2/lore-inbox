Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWAIVSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWAIVSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWAIVSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:18:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:58630 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750747AbWAIVSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:18:31 -0500
Date: Mon, 9 Jan 2006 22:18:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109211811.GB14477@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <20060109210105.GA13853@mars.ravnborg.org> <20060109210540.GA9972@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109210540.GA9972@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 09:05:40PM +0000, Christoph Hellwig wrote:
> > +#
> > +# The xfs people like to share Makefile with 2.6 and 2.4.
> > +# Utilise file named Kbuild file which has precedence over Makefile.
> > +#
> > +
> > +include $(srctree)/$(obj)/Makefile-linux-2.6
> 
> What about just putting the content of the current Makefile-linux-2.6
> into the Kbuild file directly?
People do not expect this - since the Kbuild filename is not used expect in
the top-level directory.
So as a principle of minimum suprise I left the old Makefile as-is,
and introduced the new Kbuild file.
If xfs people likes it different then they can change it anytime.

If I one day start my little "kbuild file parser to a single makefile" project
it may be the day where we do the transition.

	Sam
