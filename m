Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWGaPMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWGaPMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWGaPMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:12:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27848 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932418AbWGaPMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:12:05 -0400
Subject: Re: Fwd: PROBLEM: ide messages during boot caused by a strange
	partition table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marco gaddoni <marco.gaddoni@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b2bc9d0607310743r2ad59c59xfe0898f685e33329@mail.gmail.com>
References: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
	 <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
	 <1154343947.7230.15.camel@localhost.localdomain>
	 <3b2bc9d0607310617p21552cc8xba66f935b9ec73bd@mail.gmail.com>
	 <1154356290.7230.31.camel@localhost.localdomain>
	 <3b2bc9d0607310743r2ad59c59xfe0898f685e33329@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 16:31:08 +0100
Message-Id: <1154359868.7230.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 16:43 +0200, ysgrifennodd marco gaddoni:
> the disk before was correctly booting linux and windows2000.
> then i used the dos6.22 fdisk (?? unsure about the exact dos version)

The DOS fdisk will rewrite the C/H/S values on the drive in some cases
if the drive is a vaguely modern setup. That will trash all the
partition data you have and can lead to corruption of the data too. If
you are luck the drive geometry originally used may match the one in
hdparm -I

If you can work out the original geometry values then put those back and
fsck all the partitions with file systems on them you may be ok.

Alan

