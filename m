Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272248AbTHRSIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272251AbTHRSIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:08:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:17169 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S272248AbTHRSIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:08:50 -0400
Date: Mon, 18 Aug 2003 20:08:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Andries.Brouwer@cwi.nl,
       Dominik.Strasser@t-online.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818180845.GB3889@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, Dominik.Strasser@t-online.de,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl> <20030818132451.A22393@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818132451.A22393@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 01:24:51PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 18, 2003 at 02:19:41PM +0200, Andries.Brouwer@cwi.nl wrote:
> > The right approach is not to break userspace without any kernel
> > benefit whatsoever, but to eliminate the accumulated cruft from
> > scsi.h.
> 
> Userspace is supposed to use the glibc <scsi/scsi.h> which is there
> for exactly that reason.

Hi Christoph & others.
Does anyone see a good way to provide a framework to auto-generate
user-space headers from the kernel versions?

hpa IIRC suggested to create a separate directory:
include/abi
and then all relevant parts of the kernel should publish their public
interface in the abi directory. Would that be usefull?

Another way could be to preprocess headerfiles, and store the output
in an abi directory.

Either way it could be good to have a sketch outlined, then
something could be made in 2.7 about this.

	Sam
