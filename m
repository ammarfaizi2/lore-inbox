Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVD0Xwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVD0Xwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVD0Xwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 19:52:41 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:61112 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262105AbVD0Xwj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 19:52:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tnf3yxVOIsUcuEWU6dr5781pUli7Myl5NoMhY61sVHyl0w4YmKaPSFh92LZi8DHODPnHe5akPLghehR/pH5ezhqYqpX9H0/n2xFR5pwq7hujMBDgYrfz/qURfs/auEW9xQidG2ecnZG7gGmoA/dzJUI9sXGcaRNZjC77AqWvwpo=
Message-ID: <d4757e6005042716523af66bae@mail.gmail.com>
Date: Wed, 27 Apr 2005 19:52:39 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Device Node Issues with recent mm's and udev
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This issue started to appear in around the 2.6.11-mm series.. it
continues even now with 2.6.12-rc2-mm3.

Attempting to copy an image to a device with a tool like dd, results
in the device node being overwritten with the data, but the data is
never sent to the destination drive for instance.

To try to put it more plainly, I have a firmware image I am copying to
an ipod.  Normally the image sends with no issues and the ipod has the
new firmware.

With the recent mm's it treats the device node as a file and ls -l
will show the size of the image as the size of the device node.

Even things like fdisk are useless.  I am not sure whether this is
some sort of a udev crash or a problem with usb-storage.  Nevertheless
it is a problem, and it continues to happen.

The last non-affected mm i can think of is 2.6.11-rc4-mm1.. though I'm
fairly sure rc5 is good too.

Thanks,
Joe
