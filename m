Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUEaLuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUEaLuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEaLuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:50:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28086 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264215AbUEaLut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:50:49 -0400
Date: Mon, 31 May 2004 13:50:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@linuxmail.org, cef-lkml@optusnet.com.au,
       linux-kernel@vger.kernel.org, rob@landley.net, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040531115049.GB28188@atrey.karlin.mff.cuni.cz>
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au> <40B85024.2040505@linuxmail.org> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531031743.0d7566e3.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> btw, software suspend wrecks your swap partition if you suspend to swap but
> do not resume from swap - you need to run mkswap again.  Seems odd.

Its half-intentional. We need to change signature to something else so
that kernel knows "this is suspend partition", and I never got around
to fixing it back on unsuccessfull suspend.

I believe stefan has some script that fixes swap signature using dd if
it detects suspend signature...
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
