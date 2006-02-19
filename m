Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWBSNac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWBSNac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 08:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBSNab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 08:30:31 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:32645 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932434AbWBSNab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 08:30:31 -0500
Date: Sun, 19 Feb 2006 14:30:39 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org, rusty@rustcorp.com.au
Message-ID: <20060219133039.GA11946@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
	Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
	B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net,
	kkeil@suse.de, linux-dvb-maintainer@linuxtv.org, philb@gnu.org,
	gregkh@suse.de, dwmw2@infradead.org, rusty@rustcorp.com.au
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060219113630.GA5032@mars.ravnborg.org> <20060219125924.GB5896@linuxtv.org> <20060219131953.GA9744@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219131953.GA9744@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.198.33
Subject: Re: [v4l-dvb-maintainer] Re: kbuild: Section mismatch warnings
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 02:19:53PM +0100, Sam Ravnborg wrote:
> On Sun, Feb 19, 2006 at 01:59:24PM +0100, Johannes Stezenbach wrote:
> > ...
> > > WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text:av7110_ir_init from .text between 'av7110_attach' (at offset 0xcaa6) and 'av7110_detach'
> > > WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text:av7110_ir_exit from .text between 'av7110_detach' (at offset 0xcbc5) and 'av7110_irq'
> > 
> > These seem to be legitimate and point to the right place.
> > Patch attached.
> 
> Thanks Johannes.
> I assume you will carry the patch in the dvb tree and push to linus.

Sure, after I corrected it (av7110_ir_init shouldn't be __devexit)

Johannes
