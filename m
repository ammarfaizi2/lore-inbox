Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWC3KIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWC3KIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWC3KIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:08:10 -0500
Received: from wproxy.gmail.com ([64.233.184.232]:60430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751151AbWC3KIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:08:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EM1S3ROhD994mxJ10Gv0IYXrnBuNRwobqMBf93CVKcF4heUxb6EaFldOChQdB0tDNdxv2IP9QV7yuzoFi7BPbyYRxtbluatHbHWX46NGr1FVjDHqX63V8wbig3GQuAuQaSkrhj59iucG0XAwZ4L8Id2jrR98Pt1g9MQ1y3o1D4c=
Message-ID: <6d6a94c50603300208p3d9d2df3m29fdd9b304f606de@mail.gmail.com>
Date: Thu, 30 Mar 2006 18:08:08 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I2C initialization issue
Cc: khali@linux-fr.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing a joystick driver for blackfin linux. when my kernel
startup, I got the following messages:

root:~>dmesg
............
input: ad7142 joystick as /class/input/input0
input: ad7142 joystick at js0
i2c /dev entries driver
ad7142_js_attach: at 0x58
............

If I understood correct, the i2c bus initializtion is implemented
after the input module initializtion. That's a roadblock for me.
Because my joystick is connected to my target board through the I2C
interface. And I should call some I2C routines to initialize my
joystick chip in the input driver. Of course my driver failed.

I know there are many ways to work around this issue. But if I'm
right, I still think it should be fixed in the kernel initialization
sequence.

Thanks for your suggestions.

Regards,
-Aubrey
