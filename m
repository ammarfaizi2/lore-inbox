Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUDFT1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbUDFT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 15:27:37 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:23740 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263064AbUDFT1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 15:27:35 -0400
Date: Tue, 6 Apr 2004 20:24:47 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Bjoern Michaelsen <bmichaelsen@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406192447.GA1100@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040406031949.GA8351@lord.sinclair> <200404062004.34413.volker.hemmann@heim10.tu-clausthal.de> <20040406181146.GH6930@redhat.com> <200404062044.06533.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404062044.06533.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:44:06PM +0200, Hemmann, Volker Armin wrote:

 > I rebooted.
 > Same error, uname -r:
 > Linux energy.heim10.tu-clausthal.de 2.6.5 #1 Tue Apr 6 20:26:45 CEST 2004 i686 
 > AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
 > 
 > So yes, I am pretty sure, that I am innocent ;o)

Ok, what happens if you nuke the ..

	} else {
		sis_driver.agp_enable=sis_648_enable;
	}

in sis_get_driver() ?
That should put things back to 2.6.4 style "working" order for you.

		Dave

