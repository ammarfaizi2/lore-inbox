Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVDJXSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVDJXSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVDJXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:18:20 -0400
Received: from hermes.domdv.de ([193.102.202.1]:63751 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261634AbVDJXSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:18:01 -0400
Message-ID: <4259B425.4090105@domdv.de>
Date: Mon, 11 Apr 2005 01:17:57 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Oops in swsusp
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,
during testing of the encrypted swsusp_image on x86_64 I did get an Oops
from time to time at memcpy+11 called from swsusp_save+1090 which turns
out to be the memcpy in copy_data_pages() of swsusp.c.
The Oops is caused by a NULL pointer (I don't remember if it was source
or destination).
This Oops seems to be unrelated to the encrypted image addition as I
didn't touch any code in that area.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
