Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTAJNS3>; Fri, 10 Jan 2003 08:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAJNS3>; Fri, 10 Jan 2003 08:18:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15762
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264886AbTAJNS3>; Fri, 10 Jan 2003 08:18:29 -0500
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.10.10301100502450.31168-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10301100502450.31168-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042207998.28469.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 14:13:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 13:03, Andre Hedrick wrote:
> Oh, just let the darn thing barf a 0x51/0x04 is fine with me!
> Just an abort/unsupported command.

Sounds ok to me. We do need a barfsupressor option so we can issue
commands that may fail without confusing the user (eg multiwrite setup)

ie
	ide_hwif_barfsupress(hwif);
	ide_command....

That's very much true irrespective of the flush thing

