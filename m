Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265884AbUF2SP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUF2SP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUF2SP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:15:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:38338 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265884AbUF2SP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:15:27 -0400
Message-ID: <40E1CDEF.7050104@dilella.org>
Date: Tue, 29 Jun 2004 20:15:43 +0000
From: "Leonardo G. Di Lella" <leonardo@dilella.org>
Reply-To: leonardo@dilella.org
Organization: Di Lella Organization
User-Agent: Mozilla Thunderbird 0.5 (X11/20040624)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sony Vaio dmi_scan.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:703c64214802fa02fa2dac48692405e9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

there is an old prefix value in the dmi_scan.c.

Line: 694 (Kernel 2.6.7)

{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop
         */            
                             MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
                             MATCH(DMI_PRODUCT_NAME, "PCG-"),
                             NO_MATCH, NO_MATCH,
                             } },

The DMI_PRODUCT_NAME doesnt match on newer vaio notebooks. (The newer 
A-series from sony vaio have VGN as product name instead of PCG - older 
model)
This is the reason why the sonypi doesnt run on newer vaio notebooks.
Maybe it is better to delete the line MATCH(DMI_PRODUCT_NAME, "PCG-").

--
best regards,

Leonardo G. Di Lella

