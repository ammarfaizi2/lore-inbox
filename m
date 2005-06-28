Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVF1JPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVF1JPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVF1JPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:15:12 -0400
Received: from bay19-f35.bay19.hotmail.com ([64.4.53.85]:2516 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261821AbVF1JO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:14:29 -0400
Message-ID: <BAY19-F35B8A38C4A94BA62F2B5139CE10@phx.gbl>
X-Originating-IP: [81.155.14.152]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: variable used before set
Date: Tue, 28 Jun 2005 09:14:28 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Jun 2005 09:14:28.0822 (UTC) FILETIME=[C96D5F60:01C57BC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I just tried to compile the Linux Kernel version 2.6.11.12
with the most excellent Intel C compiler. It said

drivers/scsi/pcmcia/aha152x_stub.c(313): remark #592: variable "tmp" is used 
before its value is set
        tmp.device->host = info->host;
        ^

This is clearly broken code, since the field tmp.device has not been
initialised, and so isn't pointing to anything.

Suggest code rework.

_________________________________________________________________
Want to block unwanted pop-ups? Download the free MSN Toolbar now!  
http://toolbar.msn.co.uk/

