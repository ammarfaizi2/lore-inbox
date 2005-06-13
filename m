Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVFMPOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVFMPOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVFMPOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:14:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14809 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261592AbVFMPLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:11:25 -0400
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42AD92F2.7080108@yahoo.com.au>
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>
	 <42AD6362.1000109@rainbow-software.org>
	 <1118669975.13260.23.camel@localhost.localdomain>
	 <42AD92F2.7080108@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118675343.13773.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 16:09:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-13 at 15:06, Nick Piggin wrote:
> > Make sure you have pre-empt disabled and the antcipatory I/O scheduler
> > disabled. 
> > 
> I don't think that those could explain it.

Try it and see. The anticipatory I/O scheduler does horrible things to
my IDE streaming performance numbers and to swap performance. It tries
to merge I/O by delaying it which is deeply ungood when it comes to IDE
streaming even if its good for general I/O.

Alan

