Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTE3OR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbTE3OR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:17:27 -0400
Received: from almesberger.net ([63.105.73.239]:45841 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263681AbTE3OR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:17:26 -0400
Date: Fri, 30 May 2003 11:30:09 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Carl Spalletta <cspalletta@yahoo.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Dan Carpenter <d_carpenter@sbcglobal.net>
Subject: Re: inventing the wheel?
Message-ID: <20030530113009.A1667@almesberger.net>
References: <20030527180546.15656.qmail@web41501.mail.yahoo.com> <3ED3E224.1000402@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED3E224.1000402@gmx.net>; from c-d.hailfinger.kernel.2003@gmx.net on Wed, May 28, 2003 at 12:09:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Now we only need one additional tool to *prove* correctness of the
> kernel ;-)

Perhaps another interesting approach for such source code analyzers
would be to take a top-down view, i.e. assume a certain functional
structure, and check that all the elements are there and in the
right order.

This should be feasible for code that basically follows a certain
template, e.g. network card drivers.

This would also help with the update problem of "fill in the blanks"
type of templates, i.e. if the template changes or is augmented,
some drivers using it may no longer conform to it.

Such a top-down view could be layered on top of a bottom-up analyzer,
e.g. by - manually or automatically - translating some "skeleton"
into a set of rules of the type "if you've called X, you must later
call Y", etc.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
