Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267456AbUGNQr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267456AbUGNQr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUGNQpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:45:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40619 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267454AbUGNQo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:44:59 -0400
Message-ID: <40F562FC.50806@pobox.com>
Date: Wed, 14 Jul 2004 12:44:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se> <40F556CE.9000707@pobox.com> <20040714164253.GE7308@fs.tum.de>
In-Reply-To: <20040714164253.GE7308@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jul 14, 2004 at 11:52:46AM -0400, Jeff Garzik wrote:
> 
>>...
>>If gcc is insisting that prototypes for inlines no longer work, we have 
>>a lot of code churn on our hands ;-(  Grumble.
> 
> 
> I've counted at about 30 files with such problems in a full i386 
> 2.6.7-mm7 compile.
> 
> I've already sent patches for some of them (e.g. the dmascc.c one), and 
> they are usually pretty straightforward.

This is not a problem with the kernel.

All these files have been functioning just fine for years, with properly 
prototyped static inline functions.

Though there is a the claim that '#define inline always_inline' is 
leading to all this breakage.

	Jeff



