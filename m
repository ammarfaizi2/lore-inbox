Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSJ2Hup>; Tue, 29 Oct 2002 02:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJ2Hup>; Tue, 29 Oct 2002 02:50:45 -0500
Received: from alpha9.cc.monash.edu.au ([130.194.1.9]:5636 "EHLO
	ALPHA9.CC.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261644AbSJ2Huo>; Tue, 29 Oct 2002 02:50:44 -0500
Date: Tue, 29 Oct 2002 17:14:53 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029061453.5183C12C989@blammo.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> No. It's done over each word (short int) and the actual summation
> takes place during the address calculation of the next word. This
> gets you a checksum that is practically free.

Yep, sorry, word, not byte. My bad. The cost is in the fact 
that this whole process involves loading each word of the data
stream into a register. Which is why I also used to consider
the checksum cost as negligible. 

> A 400 MHz ix86 CPU will checksum/copy at 685 megabytes per second.
> It will copy at 1,549 megabytes per second. Those are megaBYTES!

But then why the difference in the checksum/copy and copy?
Are you saying the checksum is not costing you 864 megabytes
a second??

thanks,
Nivedita


