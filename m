Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWEQMvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWEQMvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWEQMvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:51:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45984 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932545AbWEQMvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:51:31 -0400
Subject: Re: [PATCH] ignore partition table on disks with AIX label
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060517081314.GA20415@suse.de>
References: <20060517081314.GA20415@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 14:04:15 +0100
Message-Id: <1147871055.10470.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-17 at 10:13 +0200, Olaf Hering wrote:
> dmesg will look like this:
>  sda: [AIX]  unknown partition table
> 

You should check for the overlapping partitions as well. The label
itself may be left over if someone repartitions an ex-AIX disk. Simply
adding this test is going to give one or two people a nasty "where has
my data gone" kind of shock.

Having said that perhaps the IBM people can provide proper information
on how to detect/parse the AIX partition data ?

Alan

