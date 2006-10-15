Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422890AbWJOT6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWJOT6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbWJOT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:58:43 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:53648 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1422890AbWJOT6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:58:43 -0400
Message-ID: <453292EE.4010309@drzeus.cx>
Date: Sun, 15 Oct 2006 21:58:38 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: pHilipp Zabel <philipp.zabel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use own work queue
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx> <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com> <452AB97B.5040309@drzeus.cx> <20061013075626.GB28654@flint.arm.linux.org.uk>
In-Reply-To: <20061013075626.GB28654@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> The problem is likely that the boot is continuing in parallel with
> detecting the card, because the card detection is running in its own
> separate thread.  Meanwhile, the init thread is trying to read from
> the as-yet missing root device and erroring out.
>
>   

That's what I suspect as well. I know using a root device on USB has
these kinds of problems. And the solution I've mostly seen is adding a
delay somewhere in initrd.

My experience with embedded systems is limited unfortunately, Perhaps
Russell has some nice solution for Philipp? :)

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
  OLPC, developer                     http://www.laptop.org

