Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTFILcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTFILcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:32:33 -0400
Received: from mail.ithnet.com ([217.64.64.8]:34315 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263264AbTFILcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:32:32 -0400
Date: Mon, 9 Jun 2003 13:46:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc7] AP1700-S5 system freeze :-((
Message-Id: <20030609134606.094d55ae.skraw@ithnet.com>
In-Reply-To: <3EE45E94.7070209@xss.co.at>
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
	<3EDF3310.7040501@xss.co.at>
	<3EE208F1.4000008@xss.co.at>
	<3EE45E94.7070209@xss.co.at>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andreas,

I am not quite sure if you are experiencing something similar to my problem.
Fact is this:

I have a serverworks based dual PIII board and I am experiencing freezes just
about every day. 

Equal setups:

Kernel 2.4.21-rc7
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (me: rev 23 you: rev 31)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)

Lockups during light load


Differing:

Just about everything else:
                       yours:            mine:
Storage System:        Symbios           AIC
VGA           :        ATI Rage XL       ATI Radeon RV200
Network       :        Intel/3com        Intel/Broadcom
Processor     :        Xeon UP           PIII SMP


I could already produce oops-messages on the problem and mine all come up in
kmem_cache_alloc_batch. It would be interesting where your box freezes. It
cannot be at this same place, because the code is not there in UP.
Try this (in case you are not working in front of the box):

Start box and switch to text console, enter "setterm -blank 0" to disable
screen blanker. Wait for oops. If we are lucky you will see something, get a
pencil then :-)

-- 
Regards,
Stephan
