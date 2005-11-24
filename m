Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbVKXKpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVKXKpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVKXKpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:45:16 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:61813 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030363AbVKXKpP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:45:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P12SkEyU+JCdjuDKP2Fn5vllu8gFJb/fUtx3DL1ze41oxlxKQfQLZ4cVU6SO73lVt8NLokjLU/+CFT9a5c+BMTZvin4xywHWBA+W43hhKnW/GQmaH/t2poUwWcg89qQVLFVCnKYodPmyuWe47TgeiHHVePSRSmDZK3ZjTM8r3cA=
Message-ID: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
Date: Thu, 24 Nov 2005 10:45:14 +0000
From: Vishal Linux <vishal.linux@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to get SDA/SCL bit position in the control word register of the video card?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I am trying to communicate to the monitor eeprom to get the monitor
capabilities and for that i need to have SDA/SCL bit positions in the
control word register of the video card (to read and wrtie data using
i2c protocol).

Different video card vendors have different offsets for the control
word register and different bit positions for SDA/SCL.

I tried to use linux kernel API char* get_EDID_from_BIOS(void*) and
then using kgdb to debug the kernel module (that i wrote) to get the
same  but failed to find the way to get the above.

I do have the offset of the control word register and Masking Value of
Intel and Matrox card but i would like NOT to hardcode the masking
value and the offset in my code. This will lead me to modify  my code
for the different cards.

Is there any way to get the control word register's address (and then
SDA/SCL bit position) on the linux operating system. Is this
information available to linux kernel ?

FYI : Masking Value that i am referring to is the value that has to be
ANDed to the DATA(bit - 0/1) before writing it to Control word
register so that the right bit can be written on to the SDA/SCL lines.

Any pointers to this or your guidance would be highly appreciated.

warm regards,
Vishal Soni.
