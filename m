Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289240AbSBKNaE>; Mon, 11 Feb 2002 08:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSBKN3y>; Mon, 11 Feb 2002 08:29:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289240AbSBKN3j>;
	Mon, 11 Feb 2002 08:29:39 -0500
Message-ID: <3C67C740.43AAD437@mandrakesoft.com>
Date: Mon, 11 Feb 2002 08:29:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: RFC: scheduler, and per-arch switch_to
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we really care about the third arg to the switch_to() macro?

IMHO it would be nice to define the architecture context switch
interface like

  void switch_to(struct thread_info *from, struct thread_info *to);

because we don't really seem to do much with the third arg, AFAICS.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
