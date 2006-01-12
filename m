Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWALNbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWALNbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWALNbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:31:20 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:51640 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751165AbWALNbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:31:20 -0500
Subject: Re: patch: problem with sco
From: Marcel Holtmann <marcel@holtmann.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>,
       bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com
In-Reply-To: <43C64B0C.2080903@trash.net>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
	 <1137057244.3955.3.camel@localhost.localdomain>
	 <43C64B0C.2080903@trash.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 14:31:47 +0100
Message-Id: <1137072707.5013.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

> >>A friend and I encountered a problem with sco transfers to a headset using
> >>linux (vanilla 2.6.15). While all sco packets sent by the headset were
> >>received there was no outgoing traffic.
> >>
> >>After switching debugging output on we found that actually sco_cnt was always
> >>zero in hci_sched_sco.
> 
> I'm seeing the exact same problem with a Logitech "mobile Freedom"
> headset. I'm using this patch to work around the problem:

so it seems that Broadcom really messed the SCO MTU settings up and we
have to workaround with some sane values.

Please also include the lspci for these devices.

Regards

Marcel


