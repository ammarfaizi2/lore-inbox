Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVASLLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVASLLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVASLLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:11:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41620 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261466AbVASLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:11:46 -0500
Date: Wed, 19 Jan 2005 11:11:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Karim Yaghmour <karim@opersys.com>,
       Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050119111128.GB12903@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>,
	Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
	Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <20050116161437.GA26144@infradead.org> <16874.52969.835525.775553@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16874.52969.835525.775553@tut.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 02:30:33PM -0600, Tom Zanussi wrote:
> This would allow an application to write trace events of its own to a
> trace stream for instance.

I don't think this is a good idea.  Userspace could aswell easily write
its trace into shared memory segments.

> Also, I added a user-requested 'feature'
> whereby write()s on a relayfs channel would be sent to a callback that
> could be used to interpret 'out-of-band' commands sent from the
> userspace application.

Now write as a control channel makes lots of sense, but I'd encapsulate
that differently.  Basically a net ctl file for each stream (and get
rid of ioctl in favour of this one while we're at it)

