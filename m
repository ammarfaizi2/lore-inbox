Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268153AbRGZPvz>; Thu, 26 Jul 2001 11:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268138AbRGZPvq>; Thu, 26 Jul 2001 11:51:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26638 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268145AbRGZPvc>; Thu, 26 Jul 2001 11:51:32 -0400
Subject: Re: Validating Pointers
To: andrew.r.cress@intel.com (Cress, Andrew R)
Date: Thu, 26 Jul 2001 16:52:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Cress, Andrew R" at Jul 26, 2001 08:36:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PnRQ-0003yo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Is there a general (correct) kernel subroutine to validate a pointer
> received in a routine as input from the outside world?  Is access_ok() a
> good one to use?

access_ok may do minimal checks, or no checking at all. The only point at
which you can validate a user point is when you use copy*user and
get/put_user to access the data.
