Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUI2Nbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUI2Nbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUI2Nbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:31:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:35844 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268370AbUI2Nbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:31:40 -0400
Date: Wed, 29 Sep 2004 14:31:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Message-ID: <20040929143129.A12651@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	dri-devel <dri-devel@lists.sourceforge.net>,
	Xserver development <xorg@freedesktop.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910409280854651581e2@mail.gmail.com> <20040929133759.A11891@infradead.org> <415AB8B4.4090408@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <415AB8B4.4090408@tungstengraphics.com>; from keith@tungstengraphics.com on Wed, Sep 29, 2004 at 02:29:24PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 02:29:24PM +0100, Keith Whitwell wrote:
> Christoph Hellwig wrote:
> 
> >  - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
> >  - dito or ->poll
> >  - dito for ->read
> 
> Pretty sure you couldn't get away with null for these in 2.4, at least.

Umm, of course you could.  There's only a hanfull instance defining a
->flush at all.  Similarly all file_ops for regular files and many char
devices don't have ->poll.  no ->read is pretty rare but 2.4 chæcks it
aswell.

