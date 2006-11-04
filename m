Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965597AbWKDSfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965597AbWKDSfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965598AbWKDSfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:35:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2742 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965597AbWKDSfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:35:16 -0500
Date: Sat, 4 Nov 2006 18:35:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Luugi Marsan <luugi.marsan@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Workaround for SB600 SATA ODD issue
Message-ID: <20061104183515.GA1675@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Luugi Marsan <luugi.marsan@amd.com>, linux-kernel@vger.kernel.org
References: <20061103190004.9ED8DCBD48@localhost.localdomain> <1162661809.3160.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162661809.3160.53.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 06:36:49PM +0100, Arjan van de Ven wrote:
> why put this into the ahci struct rather than in the pci device struct?
> In the place you use it you already have the pci device struct already..
> and it's really a pci device property so putting it in that struct makes
> a whole lot of sense conceptually anyway...

I think having a revision field in pci_dev that's initialized by the pci
code early on would be immensivly useful.  For now it probably makes sense
to do in ahci what all other drivers do and read it on it's own.

Adding it to the pci core and switching all the drivers over would
be a separate project.  Maybe we can sign AMD up for it as a general
kernel contribution thing? :)

