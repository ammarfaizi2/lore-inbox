Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTECU4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 16:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTECU4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 16:56:43 -0400
Received: from 147.catv45.aar01.lan.ch ([212.60.45.147]:9741 "EHLO
	bolli.homeip.net") by vger.kernel.org with ESMTP id S263416AbTECU4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 16:56:43 -0400
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Date: Sat, 03 May 2003 23:08:48 +0200
From: "Beat Bolli (privat)" <bbolli@ymail.ch>
Message-ID: <3EB42FE0.9000900@ymail.ch>
MIME-Version: 1.0
Subject: [2.5 PCMCIA SERIAL] name mismatch in 8250_cs.c
To: linux-kernel@vger.kernel.org
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en, de
X-AntiVirus: OK! AntiVir MailGate Version 2.0.0.6
	 at bolli.homeip.net has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I think I found kind of a mismatch in the PCMCIA serial driver. The file 
is called 8250_cs.c, but the driver name, driver info, version string, 
log messages and comments inside the file still refer to "serial_cs". 
This seems to confuse the new module-init-tools, which try to modprobe 
the module serial_cs which of course isn't found.

A manual "modprobe 8250_cs" works fine.

Beat Bolli

