Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVG1Tik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVG1Tik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVG1Tfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:35:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36235 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261645AbVG1Teg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:34:36 -0400
Date: Thu, 28 Jul 2005 21:34:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Alternative to TIF_FREEZE -> a notifier in the task_struct?
Message-ID: <20050728193433.GA1856@elf.ucw.cz>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net> <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz> <Pine.LNX.4.62.0507280804310.23907@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507280804310.23907@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I guess I'd prefer if you left "refrigerator()" and "try_to_freeze()"
> > functions in; there are about 1000 drivers that know/use them, and
> > some patches are probably in the queue....
> 
> Yeah but then other uses also could benefit from that.

Just don't rename try_to_freeze() to whatever... make it do whatever
you need, but don't change the name so that we don't have to fix it at
1000 places...

Or introduce new name, but keep try_to_freeze in, just calling "new"
function, so all 1000 usews don't have to be changed at the same time.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
