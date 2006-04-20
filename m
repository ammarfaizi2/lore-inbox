Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDTI0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDTI0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWDTI0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:26:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20883 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750777AbWDTI0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:26:14 -0400
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060420053604.GA15332@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com>
	 <20060419221248.GB26694@infradead.org>  <20060420053604.GA15332@suse.de>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 10:26:09 +0200
Message-Id: <1145521570.3023.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are correct on calling BS in that I was wrong to refer to it as the
> "system root".  When a task chroots relative to it's current namespace, we
> are interested in the path back to the root of that namespace, rather than
> to the chroot.  I believe the patch as stands achieves this, albeit with
> some changing of comments.

it actually doesn't; you assume there is such a path which is not a
given. For example if your mount got lazy umounted (like hal probably
does) then it's a floating mount not one tied to any tree going to the
root of any namespace.


