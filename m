Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWIZLDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWIZLDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIZLDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:03:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17097 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750798AbWIZLDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:03:47 -0400
Subject: Re: [PATCH] restore libata build on frv
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Howells <dhowells@redhat.com>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1159260980.3309.22.camel@pmac.infradead.org>
References: <20060925142016.GI29920@ftp.linux.org.uk>
	 <1159186771.11049.63.camel@localhost.localdomain>
	 <1159183568.11049.51.camel@localhost.localdomain>
	 <20060924223925.GU29920@ftp.linux.org.uk>
	 <22314.1159181060@warthog.cambridge.redhat.com>
	 <5578.1159183668@warthog.cambridge.redhat.com>
	 <7276.1159186684@warthog.cambridge.redhat.com>
	 <20660.1159195152@warthog.cambridge.redhat.com>
	 <1159199184.11049.93.camel@localhost.localdomain>
	 <1159258013.3309.9.camel@pmac.infradead.org>  <4518EA39.40309@pobox.com>
	 <1159260980.3309.22.camel@pmac.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 12:25:21 +0100
Message-Id: <1159269921.11049.190.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-26 am 09:56 +0100, ysgrifennodd David Woodhouse:
> On Tue, 2006-09-26 at 04:52 -0400, Jeff Garzik wrote:
> > The irq is a special case no matter how we try to prettyify it.  We need 
> > two irqs, and PCI only gives us one per device. 
> 
> That's fine -- but don't use zero to mean none. We have NO_IRQ for that,
> and zero isn't an appropriate choice.

Zero means "no IRQ". That's official kernel policy and true for both old
and new IDE. Architectures are supposed to remap any real "irq 0".

Might as well use NO_IRQ though, as its clearer.

Alan

