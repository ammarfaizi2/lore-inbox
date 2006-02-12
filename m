Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWBLOn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBLOn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 09:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWBLOn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 09:43:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23527 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750755AbWBLOn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 09:43:56 -0500
Date: Sun, 12 Feb 2006 15:43:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ian Kent <raven@themaw.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: Re: [RFC:PATCH 2/4] autofs4 - add v5 follow_link mount trigger method
In-Reply-To: <200602121340.k1CDeHSn019282@eagle.themaw.net>
Message-ID: <Pine.LNX.4.61.0602121542060.1213@yvahk01.tjqt.qr>
References: <200602121340.k1CDeHSn019282@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This patch adds a follow_link inode method for the root of
>an autofs direct mount trigger. It also adds the corresponding
>mount options and updates the show_mount method.
>
>+	if (sbi->type & AUTOFS_TYP_OFFSET)
>+		seq_printf(m, ",offset");
>+	else if (sbi->type & AUTOFS_TYP_DIRECT)
>+		seq_printf(m, ",direct");
>+	else
>+		seq_printf(m, ",indirect");
>+

Just a little nitpick: in English, it's usually "type" not "typ".

>+#define AUTOFS_TYP_INDIRECT     0x0001
>+#define AUTOFS_TYP_DIRECT       0x0002
>+#define AUTOFS_TYP_OFFSET       0x0004

>+	unsigned int type;


Jan Engelhardt
-- 
