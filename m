Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSK1RK6>; Thu, 28 Nov 2002 12:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSK1RK5>; Thu, 28 Nov 2002 12:10:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:56532 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266323AbSK1RK4>;
	Thu, 28 Nov 2002 12:10:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 28 Nov 2002 18:18:15 +0100 (MET)
Message-Id: <UTC200211281718.gASHIFE04317.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com
Subject: Re: [PATCH] scsi/hosts.c device_register fix
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From James.Bottomley@steeleye.com  Thu Nov 28 17:57:52 2002

	Actually, the patch is wrong.
	The device_register has to be done in scsi_add_host,
	The correct fix is to move the corresponding device_unregister
	into scsi_remove_host so that they match.

Very good. That was what I had done first, but a google search
turned up your patch and I thought that it was also OK.

	I'll also commit it to the scsi-misc-2.5 BK tree.

Hope to see it in 2.5.51.

Andries
