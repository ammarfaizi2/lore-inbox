Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTFBPGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTFBPGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:06:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60902
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262426AbTFBPGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:06:13 -0400
Subject: Re: 2.4.21 can't set IDE DMA on harddrive (HDIO_SET_DMA failed:
	Operation not permitted)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?J=E9r=F4me_Aug=E9?= <jauge@club-internet.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030602114838.GA1730@satellite.workgroup.fr>
References: <20030602114838.GA1730@satellite.workgroup.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1054563706.7495.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 15:21:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-02 at 12:48, Jérôme Augé wrote:
> I checked my logs and found that the 2.4.21 kernel use E-IDE version
> 7.00beta[34]-.2.4 and the 2.4.20 one use version 6.31.
> 
> Looks like something went wrong in the IDE code regarding DMA settings ?
> 
> Here is the output from 'lspci' for my IDE controler (Toshiba Satellite
> 2540CDT):

It used to be caught by the generic DMA driver that would just run with
BIOS settings. This approach unfortunately also tended to grab devices
that didn't work with just BIOS settings so I took it out and just left
a table of known OK devices.

I'll add the toshiba one back and I've also pinged Toshiba to see if
they will give me the docs to support it properly.

Alan

