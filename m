Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWI0HFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWI0HFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWI0HFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:05:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29650 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932398AbWI0HFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:05:38 -0400
Subject: Re: [PATCH] restore libata build on frv
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20660.1159195152@warthog.cambridge.redhat.com>
References: <20060925142016.GI29920@ftp.linux.org.uk>
	 <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20660.1159195152@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 08:05:24 +0100
Message-Id: <1159340724.3309.103.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 15:39 +0100, David Howells wrote:
> My point is that all the numbers are invalid or incorrect.  They will cause
> the arch to oops, and so need completely replacing.   

The way we deal with code which blindly pokes at legacy I/O addresses on
PowerPC is to have a check_legacy_ioport() function which will tell you
if it's safe to poke at the address in question. Perhaps that should be
extended to other architectures (some can just #define it to 0) and used
in the IDE code.

-- 
dwmw2

