Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUC0UCv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 15:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUC0UCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 15:02:51 -0500
Received: from gw.c9x.org ([213.41.131.17]:27410 "HELO b.mx.42-networks.com")
	by vger.kernel.org with SMTP id S261867AbUC0UCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 15:02:33 -0500
X-Spam-Check-By: pureftpd.org
Message-ID: <4065DDE7.9000204@skyrock.fr>
Date: Sat, 27 Mar 2004 21:02:25 +0059
From: Frank Denis <fdenis@skyrock.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040310)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfsd oops with 2.6.5-rc2-mm4
References: <4065D19A.1040903@conterra.de>
In-Reply-To: <4065D19A.1040903@conterra.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stueken wrote:
> was some exported directory quite big?

Yes, some exported directories contains a lot of small files.

 > What nfs version
> are you using? You may try "mount -o nfsvers=2 ..." or 3.

Version 3. I can give version 2 a try but there will probably a 
significant loss of performance :(

> My own Oops seems to be reproducible when using a Sun (2.8) as
> client, only.

There actually 10 clients, 9 are Linux 2.6.2-rc2-mm2, 1 is indeed a 
Solaris 2.8 box.

> It did not occur when using nfsV2. I also failed
> to reproduce the bug when mounting by an other Linux client.

Unfortunately this is a production environment and I can hardly switch 
the Solaris box off in order to make it sure that it is triggering the bug.

> So may be we observe two different bugs here.

Your situation looks similar.

I reverted to 2.6.2-rc2-mm3, the server didn't crash after 6 hours. 
Crossing fingers...
