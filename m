Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVDJPQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVDJPQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDJPQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:16:04 -0400
Received: from hermes.domdv.de ([193.102.202.1]:3844 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261509AbVDJPQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:16:01 -0400
Message-ID: <4259432F.4040206@domdv.de>
Date: Sun, 10 Apr 2005 17:15:59 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
References: <1113145420344@pavel_ucw.cz>
In-Reply-To: <1113145420344@pavel_ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[reformatted]

Pavel Machek wrote:
> Hi! What about doing it right? Encrypt it with symmetric cypher
> and store key in suspend header. That way key is removed automagically
> while fixing signatures. No need to clear anythink.

Good idea. I'll have a look though it will take a while (busy with my job).

> OTOH we may want to dm-crypt whole swap partition.

This would leave the problem that the in-kernel data would be accessible
on the swap device after resume.

> You could still store key in header... --p

Which is the good idea from step one above.

> 
> -- pavel. Sent from  mobile phone. Sorry for poor formatting.

The only remark I do have here is that swsusp would then depend on
crypto so the swsusp encryption should be a config option.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
