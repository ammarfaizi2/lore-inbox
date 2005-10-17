Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVJQHHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVJQHHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVJQHHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:07:15 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:53667 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932085AbVJQHHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:07:13 -0400
Date: Mon, 17 Oct 2005 15:07:15 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051017070715.GA3976@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051006082231.GA21800@elte.hu> <20051010172631.59d98198.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010172631.59d98198.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I come across a compile error:
drivers/video/nvidia/nv_setup.c: In function `NVCommonSetup':
drivers/video/nvidia/nv_setup.c:407: error: parse error before "do"
drivers/video/nvidia/nv_setup.c:407: error: parse error before ')' token

The context lines
in drivers/video/nvidia/nv_setup.c:

                if (nvidia_probe_i2c_connector(info, 1, &edidA))
                        nvidia_probe_of_connector(info, 1, &edidA);

in drivers/video/nvidia/nv_proto.h:

#define nvidia_probe_i2c_connector(p, c, edid) \
do {                                           \
        *(edid) = NULL;                        \
} while(0)              

...

#define nvidia_probe_of_connector(p, c, edid)  \
do {                                           \
        *(edid) = NULL;                        \
} while(0)


Regards,
Wu Fengguang
