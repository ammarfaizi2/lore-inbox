Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUHIImf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUHIImf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHIImf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:42:35 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:32897 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S266349AbUHIIka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:40:30 -0400
Subject: Re: highmem handling again
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040808192300.GA659@elf.ucw.cz>
References: <20040808192300.GA659@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092040054.28673.9.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 09 Aug 2004 18:27:34 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-08-09 at 05:23, Pavel Machek wrote:
> Hi!
> 
> I agree that swsusp_free is not the right place to restore_highmem(),
> but I can't find "right" place to do it... Best I could come up is
> with is:
> 
> It did not work at the end of swsusp_resume, or at the end of
> swsusp_restore, IIRC.

I'm doing: copy back lowmem, restore local processor context, flush
local tlb, restore highmem, allow other processors to restore their
processor contexts and flush local tlbs. It works fine here.

Nigel

