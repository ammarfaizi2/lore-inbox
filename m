Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWBWNdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWBWNdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWBWNdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:33:32 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:52442 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751219AbWBWNdb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:33:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G8ShurncjypPZGclOwsUbnarnVGx9qVXKDiD0MRnRNMzt4CkYPEgHA3q5tq29knWvJ02Ltqzq+mBF556njdkVIAtjENNyW5Z9jq1nOEV+feMeozW/k0sX+GzMmHxyJ8nZtl41xgXdnJ+e2jqfLCpKSK7Ip7ucxPrCrWeMoLvWLs=
Message-ID: <f69849430602230533s451e3be3oe47c92320e09a1f@mail.gmail.com>
Date: Thu, 23 Feb 2006 05:33:31 -0800
From: "kernel coder" <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Programmed IDE transfer size
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm working on an ide driver.Whenever a DMA read operation is
started,i never recieve the DMA interrupt.The staus register at offset
00h shows value ' 0 ',which means that the descriptor table specified
a smaller buffer size than the programmed IDE transfer size.
But occassionaly i recieved the DMA interrupt.

Actually this driver works well on another board.On that board
whenever i reduced the buffer size in physical region descriptor table
to less than the current size in the PRDT table,i again got the same
error.

I think this confirms that whenever we give smaller size in PRDT than
the programmed IDE transfer size,status register shows ' 0 ' value.

Please tell me where in kernel that programmed IDE transfer size is
being set.The transfer size in PRDT on the other board(on which driver
shows no problem) varied from 4k to 1k ,which means it is changed
frequently.

shahzad
