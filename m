Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270745AbTGUV31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270744AbTGUV30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:29:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270743AbTGUV3Z (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 21 Jul 2003 17:29:25 -0400
Date: Mon, 21 Jul 2003 23:44:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.redhat.com
Subject: Re: swsusp / 2.6.0-test1
Message-ID: <20030721214417.GI436@elf.ucw.cz>
References: <1058805510.15585.7.camel@simulacron> <20030721193615.GB473@elf.ucw.cz> <3F1C5C26.10607@kolumbus.fi> <20030721213141.GF436@elf.ucw.cz> <3F1C5F05.5030903@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1C5F05.5030903@kolumbus.fi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ah ok, so at this stage swsuspending a X desktop doesn't work in general 
> case, of course depending on video hardware? If X had some notion of 
> suspend/resume things would be easier, than insisting every single 
> driver save and restore all. After all the pci config space should be 
> enough for kernel drivers?

Look how swsusp handles it: we switch to text console (which means X
gets told to bring vga card to some sane state). We should do the same
for S3.

I'm using vesafb, which needs no special support for suspend/resume
;-). [And its very good for system stability; with notebook's LCD I
don't care about low refresh (1).]
								Pavel
(1). I've seen notebooks LCD flashing at 25Hz, but VESA modes are
fortunately better than *that*. 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
