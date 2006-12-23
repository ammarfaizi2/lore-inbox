Return-Path: <linux-kernel-owner+w=401wt.eu-S1752793AbWLWKSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbWLWKSb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 05:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbWLWKSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 05:18:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46300 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbWLWKSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 05:18:30 -0500
Subject: Re: Finding hardlinks
From: Arjan van de Ven <arjan@infradead.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 23 Dec 2006 11:18:26 +0100
Message-Id: <1166869106.3281.587.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> If user (or script) doesn't specify that flag, it doesn't help. I think 
> the best solution for these filesystems would be either to add new syscall
>  	int is_hardlink(char *filename1, char *filename2)
> (but I know adding syscall bloat may be objectionable)

it's also the wrong api; the filenames may have been changed under you
just as you return from this call, so it really is a
"was_hardlink_at_some_point()" as you specify it.
If you make it work on fd's.. it has a chance at least.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

