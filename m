Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWF3XIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWF3XIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWF3XIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:08:37 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:44701 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932195AbWF3XIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:08:36 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
Date: Sat, 1 Jul 2006 01:09:39 +0200
User-Agent: KMail/1.7.2
Cc: Alessio Sangalli <alesan@manoweb.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607010109.40486.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 1378;
	Body=7 Fuz1=7 Fuz2=7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 July 2006 00.18, Linus Torvalds wrote:
> 
> On Sat, 1 Jul 2006, Daniel Ritz wrote:
> > 
> > nope. but from the docs available i would _guess_ this thing is really
> > similar to the 82443BX/82371AB combination. at least the SMBus base address
> > register is hidden at the very same place (32bit at 0x90 in function 3 of the
> > "south" brigde)...so the attached little patch might be enough to fix things...
> 
> Alessio has PCI ID 8086:7194, which is not the 82443MX_3, so you'd need 
> something like this instead (but yes, it might indeed be the standard 
> PIIX4 quirks).
> 

errm...no. the SMBus device is in device 00:07.3 (power management controller)...
and that has ID 8086:719b (from his lspci -vvx output)...

rgds
-daniel
