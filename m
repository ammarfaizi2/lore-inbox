Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSIATAv>; Sun, 1 Sep 2002 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSIATAu>; Sun, 1 Sep 2002 15:00:50 -0400
Received: from p508B7F3F.dip.t-dialin.net ([80.139.127.63]:48793 "EHLO
	p508B7F3F.dip.t-dialin.net") by vger.kernel.org with ESMTP
	id <S317331AbSIATAr>; Sun, 1 Sep 2002 15:00:47 -0400
Date: Sun, 1 Sep 2002 21:05:04 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question on spinlocks
Message-ID: <20020901210504.A22882@bacchus.dhis.org>
References: <200209011927.53853.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209011927.53853.oliver@neukum.name>; from oliver@neukum.name on Sun, Sep 01, 2002 at 07:27:53PM +0200
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 07:27:53PM +0200, Oliver Neukum wrote:

> is the following sequence legal ?
> 
> spin_lock_irqsave(...);
> ...
> spin_unlock(...);
> schedule();
> spin_lock(...);
> ...
> spin_unlock_irqrestore(...);

No; spin_lock_irqsave/spin_unlock_irqrestore and spin_lock/spin_unlock
have to be used in matching pairs.

  Ralf
