Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWJAQoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWJAQoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWJAQoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:44:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13711 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751247AbWJAQod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:44:33 -0400
Message-ID: <451FF06F.5060100@garzik.org>
Date: Sun, 01 Oct 2006 12:44:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SCSI] IPS bug found
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gcc warning indicates a bug:

drivers/scsi/ips.c: In function ‘ips_insert_device’:
drivers/scsi/ips.c:7123: warning: ‘index’ may be used uninitialized in 
this function

ips_register_scsi() and ips_free() may be called on an uninitialized 
'index', if the preceding functions fail.

