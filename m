Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbTDRSZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbTDRSZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:25:13 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:2822 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263192AbTDRSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:25:12 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.67-mm4: select-speedup.patch breaks Evolution
Date: Fri, 18 Apr 2003 19:36:50 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200304181936.50161.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-18 at 17:34, Felipe Alfaro Solana wrote:
> 2.5.67-mm4 breaks Evolution 1.2.3: when clicking on
> "Sending/Receiving" toolbar button, Evolution displays the progress
> dialog box but it hangs forever, that is, no mail is sent or received. 
> All my accounts are POP3.
>
> Reverting "select-speedup.patch" fixes the problem.
>

This isn't localised to Evolution. KDE 3.2 (CVS) will not get past the 
"Initialising peripherals" stage, for whatever reason.

Backing out this patch does indeed help, thanks for the hint. It would 
have taken me a while to isolate it, as I can't imagine what KDE's 
doing with sys_select()..

Cheers,
Alistair.

