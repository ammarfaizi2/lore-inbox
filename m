Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWAYLLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWAYLLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWAYLLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:11:11 -0500
Received: from terra.ane.cmc.osaka-u.ac.jp ([133.1.74.3]:63706 "EHLO
	terra.ane.cmc.osaka-u.ac.jp") by vger.kernel.org with ESMTP
	id S1751118AbWAYLKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:10:52 -0500
Message-ID: <43D75CBC.9040805@ist.osaka-u.ac.jp>
Date: Wed, 25 Jan 2006 20:10:52 +0900
From: Zongsheng Zhang <zhang@ist.osaka-u.ac.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCP fast retransmit/recovery
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

About TCP fast retransmit/recovery, it is described in RFC 2581:

1) When the third duplicate ACK is received, set ssthresh to no more
than the value max(FlightSize/2, 2*SMSS).

2) Retransmit the lost segment and set cwnd to ssthresh plus 3*SMSS.

However, in kernel 2.4.31 (or 2.6.15), cwnd is always set to 1 (in
tcp_enter_loss()), even there is only one packet is drop.

Does anyone know the reason?

Regards,

-- 
Zongsheng Zhang
zhang@ist.osaka-u.ac.jp
