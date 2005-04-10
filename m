Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVDJS3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVDJS3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVDJS07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:26:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261555AbVDJSTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:19:07 -0400
Date: Sun, 10 Apr 2005 20:18:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Message-ID: <20050410181846.GB1349@elf.ucw.cz>
References: <1113145420344@pavel_ucw.cz> <4259432F.4040206@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4259432F.4040206@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hi! What about doing it right? Encrypt it with symmetric cypher
> > and store key in suspend header. That way key is removed automagically
> > while fixing signatures. No need to clear anythink.
> 
> Good idea. I'll have a look though it will take a while (busy with my job).
> 
> > OTOH we may want to dm-crypt whole swap partition.
> 
> This would leave the problem that the in-kernel data would be accessible
> on the swap device after resume.

I meant "when dm-crypt is used, encrypting swsusp data with second key
is no longer _that_ nice"...

So perhaps we should encrypt swap by default with random key, and
reuse same code for swsusp...

> > -- pavel. Sent from  mobile phone. Sorry for poor formatting.
> 
> The only remark I do have here is that swsusp would then depend on
> crypto so the swsusp encryption should be a config option.

Yes. Not evereyone has so fast CPU that encryption is NOP.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
