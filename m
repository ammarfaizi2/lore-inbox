Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHGPGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHGPGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 11:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUHGPGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 11:06:49 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13250 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263003AbUHGPGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 11:06:42 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: dleonard@dleonard.net, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040806224743.GA19131@suse.de>
References: <20040806143258.GB23263@suse.de>
	 <Pine.LNX.4.44.0408061020220.8255-100000@pooka.dleonard.net>
	 <20040806224743.GA19131@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091887453.18408.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 15:04:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 23:47, Jens Axboe wrote:
> But thanks for high lighting why filtering is bad for new devices.

Filtering is essential. If you have CAP_SYS_RAWIO set then anything
goes. Root is entitled to reflash his hard disk to report all files
having setuid bits, or to total the media or to password lock it.

End users are not and the only sane kernel behaviour for the "unsure"
case is "-EPERM". If its not the right behaviour we have setuid bits.
If it was the other way around your end user just password locked all
your disks with a password you'll never recover. 


Alan

