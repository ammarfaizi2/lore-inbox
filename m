Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUFGShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUFGShd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUFGShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:37:33 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:57633 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262574AbUFGShb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:37:31 -0400
Date: Mon, 7 Jun 2004 20:43:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Sam Ravnborg'" <sam@ravnborg.org>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] CRIS architecture update
Message-ID: <20040607184309.GA3152@mars.ravnborg.org>
Mail-Followup-To: Mikael Starvik <mikael.starvik@axis.com>,
	'Sam Ravnborg' <sam@ravnborg.org>, 'Jeff Garzik' <jgarzik@pobox.com>,
	'Andrew Morton' <akpm@osdl.org>,
	'Linux Kernel' <linux-kernel@vger.kernel.org>,
	'Bartlomiej Zolnierkiewicz' <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <BFECAF9E178F144FAEF2BF4CE739C668D47C24@exmail1.se.axis.com> <BFECAF9E178F144FAEF2BF4CE739C66818F49D@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66818F49D@exmail1.se.axis.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 07:53:30AM +0200, Mikael Starvik wrote:
> >The general rule is to locate drivers under drivers/, even the arch 
> >specific ones. This allows for easier grepping after users of a
> >given API etc.
> 
> Ok, if that is a general rule I can move them (but the patch will
> be large...).

Please do so. As Bartlomiej note the rule is to keep drivers under:
drivers/<subsystem>/<arch>

The most efficient way to do the move is to send Linus a direct
mail with a simple shell script that does the moving of the files.
Along the lines of:

mkdir -p drivers/ide/cris
mv arch/cris/drivers/ide/* drivers/ide/cris

etc.

	Sam
