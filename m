Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289907AbSAPJsi>; Wed, 16 Jan 2002 04:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289909AbSAPJsS>; Wed, 16 Jan 2002 04:48:18 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:34954 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S289907AbSAPJsL>; Wed, 16 Jan 2002 04:48:11 -0500
Message-Id: <200201160947.g0G9lxv15813@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: SCSI host numbers?
Date: Wed, 16 Jan 2002 11:47:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu> <200201151219.g0FCJUD15091@lmail.actcom.co.il> <200201160703.g0G73Sr27779@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201160703.g0G73Sr27779@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 January 2002 09:03 am, Richard Gooch wrote:
> But if you load, unload and reload a host driver, and it's not listed
> in scsihosts=, then won't it get a different host number each time?

In the fist time that it registers it is added to scsi_host_no_list
(see code under "if (flag_new) {" in scsi/host.c).
Than it will get the same number again every time.

scsi_host_no_list is discarded only when scsi_mod
gets unloaded (that is if compiled as module).

-- Itai
