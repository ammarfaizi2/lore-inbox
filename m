Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTDWXHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTDWXHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:07:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38274
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264289AbTDWXHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:07:50 -0400
Subject: Re: problem with a cobalt RaQ550 system and DMA (Serverworks OSB4
	in impossible state)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Bornet <Olivier.Bornet@puck.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030423212713.GD21689@puck.ch>
References: <20030423212713.GD21689@puck.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 23:21:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-23 at 22:27, Olivier Bornet wrote:
> I'm trying to install Debian on 4 RaQ550 with each 2 80GB disks. All
> seems OK with 3 of RaQ, but with one, it crash when I put the two disks
> in a RAID1 meta device. In fact, it as crash at about 6% before the 70GB
> partition is fully synchronized.


Bad block I think. Its a bug fixed in 2.4.21pre.  It trips a sanity
check for an OSB4 bug inadvertantly. 2.4.21pre handles CSB5 with full
UDMA and OSB4 in MWDMA2 without tripping wrongly.

If your chipset is CSB5 you can also just comment out the check and
rebuild


Alan

