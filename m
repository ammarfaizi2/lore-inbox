Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUJWClb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUJWClb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbUJVXfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:35:02 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:43362 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269267AbUJVXdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:33:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "David S. Miller" <davem@redhat.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Input: sunkbd concern
Date: Fri, 22 Oct 2004 18:33:04 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410221833.04057.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been looking at sunkbd.c and it seems that it attaches not only to
ports that speak SUNKBD protocol but also to ports that do not specify any
protocol:

	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
		return;

Was that an oversight or it was done intentionally?

Thanks!

-- 
Dmitry
