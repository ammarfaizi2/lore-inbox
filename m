Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSBECgq>; Mon, 4 Feb 2002 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSBECge>; Mon, 4 Feb 2002 21:36:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287111AbSBECgX>;
	Mon, 4 Feb 2002 21:36:23 -0500
Message-ID: <3C5F4522.8D4D74A6@mandrakesoft.com>
Date: Mon, 04 Feb 2002 21:36:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3] wavelan_cs.c : new WE api
In-Reply-To: <20020204110138.B6533@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments pertaining to all three of wavelan, wavelan_cs, and netwave_cs:
* wv_splhi should really just be spin_lock_irqsave.  calling
spin_lock_irqsave with 'flags' from another function is non-portable. 
doing so to an inline function is just barely portable, and is
discouraged :)
* I still see a couple save_flags/restore_flags in there...

otherwise looks ok to me.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
