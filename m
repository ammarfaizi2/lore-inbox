Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVLETUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVLETUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVLETUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:20:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41192 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932510AbVLETUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:20:15 -0500
Date: Mon, 5 Dec 2005 19:20:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Buesch <mbuesch@freenet.de>, Jouni Malinen <jkmaline@cc.hut.fi>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Feyd <feyd@seznam.cz>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Message-ID: <20051205192006.GC28433@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Michael Buesch <mbuesch@freenet.de>,
	Jouni Malinen <jkmaline@cc.hut.fi>, bcm43xx-dev@lists.berlios.de,
	linux-kernel@vger.kernel.org, Feyd <feyd@seznam.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <200512051208.16241.mbuesch@freenet.de> <20051205141935.GC8940@jm.kir.nu> <200512051528.33146.mbuesch@freenet.de> <43948C65.4060405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43948C65.4060405@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 01:52:21PM -0500, Jeff Garzik wrote:
> In general, Jouni's points are good, as are Michael's.
> 
> The key question is about the size of the SoftMAC code.  If its huge, an 
> ieee80211 sub-module makes sense.  If it's not, then adding the code to 
> net/ieee80211 makes a lot more sense.
> 
> Certainly some chips will use more ieee80211 code than others.  This is 
> no different than ethernet NICs:  some make use of TSO and checksum 
> offload code included in every kernel, while for other NICs the kernel 
> TSO/csum code is just dead weight.
> 
> In general, adding directly to net/ieee80211 is preferred, UNLESS there 
> are overriding reasons not to do so (such as a huge size increase).

I tend to disagree a bit here.  If it can be separate without making the
API more complicated a separate module is nicer, if the API would get nasty
integerating it is better.  And nevermind whether it's a separate module or
not it should live in net/ieee80211/ ;-)

In either case ?I think this decision is better left until the code is in
an almost mergeable shape, because then the details will be clear.
