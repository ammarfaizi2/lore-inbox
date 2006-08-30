Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWH3CMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWH3CMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 22:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWH3CMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 22:12:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:33976 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751517AbWH3CMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 22:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EZL9RqnlLpViNYt4kNf70ungVI/+AD2vJndLpy8as/N26INZEwA4G3bojTylC+pyfinUoPgEk8RuTz+pGP6M/M/II3c67kAsp0/WdDhNDGKEYaI4QT2fhYY3oCnZajGkBJ7wh52vMAkudsRwUzC1kOhacmdZmq4CyEiLJ1xMbks=
Message-ID: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>
Date: Wed, 30 Aug 2006 07:42:32 +0530
From: "Rick Brown" <rick.brown.3@gmail.com>
To: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Spinlock query
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In my driver (Process context), I have written the following code:

--------------------------------------------
spin_lock(lock)
...
//Critical section to manipulate driver data
...
spin_u lock(lock)
---------------------------------------------

I have written similar code in my interrupt handler (Interrupt
context). The driver data is not accessed from anywhere else. Is my
code safe from any potential concurrency issues? Is there a need to
use spin_lock_irqsave()? In both the places?

I intend to run the driver on SMP machine.

Regards,

Rick
