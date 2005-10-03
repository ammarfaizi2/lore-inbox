Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933010AbVJCRGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbVJCRGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbVJCRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:06:54 -0400
Received: from leo.gold.ac.uk ([158.223.1.4]:39576 "EHLO leo.gold.ac.uk")
	by vger.kernel.org with ESMTP id S933008AbVJCRGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:06:53 -0400
Date: Mon, 3 Oct 2005 18:06:39 +0100 (BST)
From: Martin Drallew <m.drallew@fatsquirrel.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Connection reset by peer - TCP window size oddity ?
In-Reply-To: <Pine.GSO.4.61.0510031241580.29231@scorpio.gold.ac.uk>
Message-ID: <Pine.GSO.4.61.0510031753020.29714@scorpio.gold.ac.uk>
References: <Pine.GSO.4.61.0510031241580.29231@scorpio.gold.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Goldsmiths-MailScanner-Information: See http://www.gold.ac.uk/infos/cs/mailscanner/ for more information
X-Goldsmiths-MailScanner: Found to be clean
X-MailScanner-From: m.drallew@fatsquirrel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graham Murray <graham@xxxxxxxxx> writes:
> I think that you have overlooked one detail in the output. Both
> systems have declared window scaling of 2, so when otter sets the
> window size of 1984 in the packet it is actually advertising a window
> of 7936, which you are not exceeding. You do not say what type of
> system otter is (or what OS it is running), so one explanation is that
> otter has just mirrored your 'wscale 2' in its SYN-ACK without
> actually meaning it.
You're absolutely right of course, not a kernel bug, just dimwittedness 
on my part. Turning off window scaling does seem to be an effective workaround.
Judging from a quick Google it seems there is still a lot of kit out there 
that breaks window scaling :(

Many thanks for this and thanks to everyone that replied.

Martin
