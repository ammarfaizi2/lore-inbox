Return-Path: <linux-kernel-owner+w=401wt.eu-S932933AbWLSUPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWLSUPs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWLSUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:15:48 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:39354 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933AbWLSUPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:15:47 -0500
Date: Tue, 19 Dec 2006 21:15:44 +0100 (MET)
From: Oliver Neukum <oliver@neukum.name>
To: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <247966.89742.qm@web32915.mail.mud.yahoo.com>
In-Reply-To: <247966.89742.qm@web32915.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612192113.40102.oliver@neukum.name>
X-RZG-AUTH: kN+qSWxTQH+Xqix8Cni7tCsVYhPCm1GP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 19. Dezember 2006 20:21 schrieb J:
> Hi,
> I read usb-serial.c code (in 2.6.19) and I cannot
> figure out how it is
> supposed to prevent race condition and premature
> deletion of usb_serial
> structure. I see that the code attempts to protect
> usb_serial by ref
> counting, but it does not appear to be correct. I am
> not 100% sure in my
> findings, so I will appreciate if somebody will double
> check.

This code depends on protection from BKL.

	Regards
		Oliver
