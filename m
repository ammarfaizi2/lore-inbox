Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSAMUm0>; Sun, 13 Jan 2002 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288141AbSAMUmR>; Sun, 13 Jan 2002 15:42:17 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:16034 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S288127AbSAMUmG>; Sun, 13 Jan 2002 15:42:06 -0500
Message-Id: <200201132041.g0DKfeg30866@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: SCSI host numbers?
Date: Sun, 13 Jan 2002 22:41:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu> <200201022335.g02NZaj10253@lmail.actcom.co.il> <200201060144.g061i9E09115@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201060144.g061i9E09115@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 January 2002 03:44 am, Richard Gooch wrote:
> Where exactly is the host_id for an unregistered host being
> remembered?

Sorry for the late reply. I was away from Email for the whole week.

Scsi host numbers (for both regstered and unregistered hosts)
are preserved in scsi_host_no_list.

The list is used in the function scsi_register (in drivers/scsi/hosts.c).
Same function also adds new hosts to the list.

The list can be initialized (from boot parameters ?) by 
the function scsi_host_no_init (drivers/scsi/scsi.c).

-- Itai
