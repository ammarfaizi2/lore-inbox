Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbUDFUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbUDFUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:34:09 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:39358 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263997AbUDFUeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:34:05 -0400
Date: Tue, 6 Apr 2004 21:31:22 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Bjoern Michaelsen <bmichaelsen@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406203122.GB1100@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040406031949.GA8351@lord.sinclair> <200404062044.06533.volker.hemmann@heim10.tu-clausthal.de> <20040406192447.GA1100@redhat.com> <200404062206.38731.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404062206.38731.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 10:06:38PM +0200, Hemmann, Volker Armin wrote:
 >  static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
 >  {
 > -       if (bridge->dev->device == PCI_DEVICE_ID_SI_648 ||
 > -           bridge->dev->device == PCI_DEVICE_ID_SI_746) {
 > -               if (agp_bridge->major_version == 3) {
 > +        if (bridge->dev->device == PCI_DEVICE_ID_SI_648 ||
 > +           bridge->dev->device == PCI_DEVICE_ID_SI_746) {
 > +               if (agp_bridge->major_version == 3 && 
 > agp_bridge->minor_version < 5) {
 > +                       sis_driver.agp_enable=sis_648_enable;
 > +               } else {

Ah, a clue. lspci -vvv output please ?

		Dave
