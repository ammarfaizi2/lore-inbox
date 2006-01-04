Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWADSMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWADSMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWADSMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:12:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030255AbWADSMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:12:32 -0500
Date: Wed, 4 Jan 2006 19:12:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/pcmcia/aha152x_stub.c: variable used before set
Message-ID: <20060104181230.GR3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is still present in recent kernels.

cu
Arian


----- Forwarded message from d binderman <dcb314@hotmail.com> -----

Date: 	Tue, 28 Jun 2005 09:14:28 +0000
From: d binderman <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: variable used before set

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


----- End forwarded message -----

