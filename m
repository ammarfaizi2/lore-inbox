Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUCVRxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUCVRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:53:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5854 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261443AbUCVRx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:53:28 -0500
Message-ID: <405F2807.3000202@pobox.com>
Date: Mon, 22 Mar 2004 12:53:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?Big5?B?IkMuTC4gVGllbiAtIKXQqdPCpyI=?= <cltien@cmedia.com.tw>
CC: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu,
       =?Big5?B?pqyrSLhzstUtuvSttiBTdXBwb3J0IKtIvWM=?= 
	<support@cmedia.com.tw>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ANN: cmpci 6.64 released
References: <92C0412E07F63549B2A2F2345D3DB515F7D3EA@cm-msg-02.cmedia.com.tw>
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D3EA@cm-msg-02.cmedia.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.L. Tien - ¥Ð©ÓÂ§ wrote:
> Hi,
> 
> I made many changes for cmpci.c since last release. Changes are made as follows:
> 
> 1. Fix the S/PDIF out programming bug appeared in 6.16.
> 2. Support 8338 4-channel playback.
> 3. S/PDIF loop can be used after AC3 playback.
> 4. Legacy devices (FM, MPU401 and gameport) are served by other modules.
>    Now the code is thinner.
> 5. Remove parameters setting from kernel configure menu, they can be
>    set easily when loading the module.
> 6. Add spdif_out to output 44.1K/48K 16-bit stereo to S/PDIF out.
> 7. Add hw_copy to duplicate audio of front speakers to surround speakers.
> 8. Change code to minimum patch for kernel 2.6.

The driver looks pretty good, for both 2.4 and 2.6.  And the listed
changes above sound OK.  I see the driver is smaller now.

May I respectfully request that you submit your driver update in the
form of multiple patches, one patch per email?  This is the normal
method of submitting changes to the Linux kernel.  For example, create
and send 8 patches to Andrew Morton for inclusion in the 2.6.x kernel.
Each patch is applied after the last one, in succeeding order.  Typical
email subjects would look like

[PATCH 1/8] cmpci: fix s/pdif out
[PATCH 2/8] cmpci: support 8338 4-channel
[PATCH 3/8] cmpci: s/pdif loop
etc.

Splitting up changes in this manner allows for better verification, and
makes it easier to narrow down bugs to a specific change.  Large "one
big patch" updates often solve many bugs, and then add a few new bugs.

Best regards and thanks,

	Jeff



