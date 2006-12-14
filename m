Return-Path: <linux-kernel-owner+w=401wt.eu-S932806AbWLNPh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbWLNPh4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbWLNPh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:37:56 -0500
Received: from thunk.org ([69.25.196.29]:43695 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932806AbWLNPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:37:55 -0500
Date: Thu, 14 Dec 2006 10:37:54 -0500
From: Theodore Tso <tytso@mit.edu>
To: thunder7@xs4all.nl
Cc: Arjan van de Ven <arjan@infradead.org>,
       Franck Pommereau <pommereau@univ-paris12.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config options
Message-ID: <20061214153754.GD9079@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, thunder7@xs4all.nl,
	Arjan van de Ven <arjan@infradead.org>,
	Franck Pommereau <pommereau@univ-paris12.fr>,
	linux-kernel@vger.kernel.org
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org> <45813E67.80709@univ-paris12.fr> <1166098747.27217.1018.camel@laptopd505.fenrus.org> <20061214151745.GC9079@thunk.org> <20061214152721.GA5652@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214152721.GA5652@amd64.of.nowhere>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	  1 Gigabyte or more total physical RAM, answer "off" here.
> 

I don't think your proposed wording (1 gigabyte or more) versus (more
than 1 gigabyte) doesn't really change the sense of this.

If we want to be even more explicit about this, then if the CPU level
selected by the user is greater than Pentium-M (or whatever is was the
oldest CPU that didn't have NX support --- Arjan?) we shouldn't offer
this choice at all, and force CONFIG_HIGHMEM64G.  We can give the user
a choice if CONFIG_EMBEDDED is enabled, but otherwise, if the CPU
level is new enough, I think we can safely make the argument that for
nearly all systems, they have enough memory and speed that perhaps we
should just simply always use HIGHMEM64G.

						- Ted
