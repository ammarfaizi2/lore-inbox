Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVF1Vzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVF1Vzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVF1Vy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:54:29 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:12232 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261383AbVF1Vx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:53:26 -0400
Date: Tue, 28 Jun 2005 23:53:13 +0200
From: Michael Becker <michbec@t-online.de>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Michael Becker <michbec@t-online.de>
Organization: Privat
X-Priority: 3 (Normal)
Message-ID: <118494907.20050628235313@t-online.de>
To: k8 s <uint32@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: IPSec Inbound Processing Basic Doubt
In-Reply-To: <699a19ea05062810311934eb91@mail.gmail.com>
References: <699a19ea050623105516cd5eb8@mail.gmail.com>
 <506243806.20050627182416@t-online.de>
 <699a19ea05062810087b79f12f@mail.gmail.com>
 <699a19ea05062810311934eb91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ID: JbQwAYZcgev15jeqjhB7tdcgzWAY59imA5gAP9GlzZwjwgoBVIGzQE
X-TOI-MSGID: c0ee8231-26a8-48b9-97e1-3cbefdaaf9dc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ks> Also can you please tell me what is dst_input() forloop meant for .
ks> Infact the code seems to match for dst_output() in terms of the 
ks> NET_XMIT_BYPASS usage.
ks> Infact I saw that ip_rcv_finish() calls this dst_input() what purpose
ks> does it serve.

I assume most of the time or maybe always the for-loop reduces to a single
function call, either ip_forward or ip_local_deliver.
(see ip_route_input_slow, watch out for rth->u.dst.input = ...)

Maybe someone else can explain, if there are scenarios where more that
one dst input function comes into play or whether it was just done to
keep it analog to dst_output ...?

Best regards
     Michael Becker

Hochschule Niederrhein - Krefeld, Germany

