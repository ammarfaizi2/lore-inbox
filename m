Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVCBHA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVCBHA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 02:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVCBHA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 02:00:26 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:43763 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262204AbVCBHAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 02:00:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Fz9Y1yhHGtPIuR0HGQ3AaEVmwGL7cgXrPadl+A1WwjHoMEZ+lf7londG04VAQjl73g4VPnll+LooTS7U0m2YwVdqb8cpwZlAmEPhFRosLeACKcwgNByqASchPVrhBoGXqST06PpxRvWpFsMmpuJUyTasdcLNTjzA07tnK+Dzw2I=
Message-ID: <3cac075b050301230046289a03@mail.gmail.com>
Date: Wed, 2 Mar 2005 12:00:20 +0500
From: Nauman <mailtonauman@gmail.com>
Reply-To: Nauman <mailtonauman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SCSI Target Mode issue...... pls help
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all the gurus out there, 
i have written simple Target for SCSI device. its in very early stage.
I started to handle simple commands from the INITIATOR like INQUIRY,
READ CAPACITY , REPORT LUN.
Now i am upto READ and WRITE. I have responded READ properly. Problem
is in WRITE command. For instance there is a case when i get multiple
WRITE command from INITIATOR
i queue command as i receive it. CTIO has to be sent to firmware for
each recieved command  . in my case i send CTIO as i recieve the
command. now firmware has to send back the response for each CTIO i
sent. here is whats happening
i get 2 commands for WRITE. send CTIO for cmd1 and cmd2 and what i get
back from firmware is response of second cmd which is cmd2. cmd1's
command time out occurs and it fails to respond.

if any one has done basic handshake and handled READ and WRITE for
TARGET mode then please share ur knowledge......
Best Regards,
-- 
When the going gets tough, The tough gets going...!
Peace ,  
Nauman.
