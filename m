Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSFZRnz>; Wed, 26 Jun 2002 13:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSFZRny>; Wed, 26 Jun 2002 13:43:54 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:36357 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316712AbSFZRnx>;
	Wed, 26 Jun 2002 13:43:53 -0400
Date: Wed, 26 Jun 2002 10:43:47 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Paul Vojta <vojta@Math.Berkeley.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix .text.exit error in dmfe.c
Message-ID: <20020626174346.GA5447@kroah.com>
References: <200206260418.VAA10648@blue3.math.Berkeley.EDU> <Pine.NEB.4.44.0206261119460.4790-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206261119460.4790-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 29 May 2002 16:36:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 11:22:33AM +0200, Adrian Bunk wrote:
> 
> Your patch works, but as long as tulip hasn't become a hotpluggable driver
> the following patch (that also fixes a similar .text.exit error in
> de2104x.c)  should be more correct:

All pci drivers that use the pci_module_init() are now hotpluggable, due
to PCI Hotplug systems :)

The devexit_p combined with __devexit solution seems to be the preferred
way to handle this problem.

greg k-h
