Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTIAQW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTIAQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:22:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:37904 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263011AbTIAQWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:22:47 -0400
Date: Mon, 1 Sep 2003 18:22:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
       tigran@aivazian.fsnet.co.uk
Subject: Re: dontdiff for 2.6.0-test4
Message-ID: <20030901162244.GA1041@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
	tigran@aivazian.fsnet.co.uk
References: <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901163958.A24464@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 04:39:58PM +0100, Christoph Hellwig wrote:
> > I have updated dontdiff in the usual place:
> >   http://www.moses.uklinux.net/patches/dontdiff
> > /usr/src/linux/Documentation/SubmittingPatches
> 
> Btw, what about putting this somewhere in the kernel tree?

I do not like dontdiff to be part of the kernel tree.
What is included in dontdiff is redundant information already known
by kbuild. Effectively dontdiff should not list any files that would
not be removed during a "make mrproper".

Instead why not use the knowledge kbuild has and implement
'make dontdiff'

This could generate the list of files used for 'diff -X'.
I can try to hack up something during the week just to see if
it looks ok.

	Sam
