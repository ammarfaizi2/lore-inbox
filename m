Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274472AbRITMwc>; Thu, 20 Sep 2001 08:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274473AbRITMwW>; Thu, 20 Sep 2001 08:52:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274472AbRITMwR>; Thu, 20 Sep 2001 08:52:17 -0400
Subject: Re: broken VM in 2.4.10-pre9
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Thu, 20 Sep 2001 13:57:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ebiederm@xmission.com (Eric W. Biederman),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20010920112110Z16256-2757+869@humbolt.nl.linux.org> from "Daniel Phillips" at Sep 20, 2001 01:28:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k3O2-0005Fr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On September 20, 2001 12:04 am, Alan Cox wrote:
> > Reverse mappings make linear aging easier to do but are not critical (we
> > can walk all physical pages via the page map array). 
> 
> But you can't pick up the referenced bit that way, so no up aging, only
> down.

#1 If you really wanted to you could update a referenced bit in the page
struct in the fault handling path.

#2 If a page is referenced multiple times by different processes is the
behaviour of multiple upward aging actually wrong.

Alan
