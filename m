Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVDJS7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDJS7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDJS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:58:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11965 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261577AbVDJS5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:57:47 -0400
Date: Sun, 10 Apr 2005 20:56:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Message-ID: <20050410185655.GD1349@elf.ucw.cz>
References: <1113145420344@pavel_ucw.cz> <4259432F.4040206@domdv.de> <20050410181846.GB1349@elf.ucw.cz> <200504102045.22323.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504102045.22323.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Hi! What about doing it right? Encrypt it with symmetric cypher
> > > > and store key in suspend header. That way key is removed automagically
> > > > while fixing signatures. No need to clear anythink.
> 
> You might want to leave the key in the kernel image. You need to boot the
> same image anyway. Leaving the key in the header will not increase
> security while the os is down.

I believe leaving it in the header will be easier, and it is more
easily wiped, there, too.

If suspend fails, and user boots with noresume and mkswaps, key in
header will get rewritten, too. Good.
									Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
