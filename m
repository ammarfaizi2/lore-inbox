Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVBCDnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVBCDnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVBCDnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:43:21 -0500
Received: from stinkfoot.org ([65.75.25.34]:46552 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S262941AbVBCDm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:42:56 -0500
Message-ID: <42019E0E.1020205@stinkfoot.org>
Date: Wed, 02 Feb 2005 22:44:14 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e1000, sshd, and the infamous "Corrupted MAC on input"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I've been having quite a time with the e1000 driver running at gigabit 
speeds.  Running it at 100Fdx has never been a problem, which I've done 
done for a long time. Last week I picked up a gigabit switch, and that's 
when the trouble began.  I find that transferring large amounts of data 
using scp invariably ends up with sshd spitting out "Disconnecting: 
Corrupted MAC on input."  After deciding I must have purchased a bum 
switch, I grabbed another model.. only to get the same error.
Finally, I used a crossover cable between the two boxes, which resulted 
in the same error from sshd again.

Both systems are 2.6.10, with 4k stacks, and regparm enabled. system 1 
has an onboard Intel 82547EI, system 2 has an onboard Intel 82545EM, 
both have NAPI enabled... Oddly, running the nics at 100Fdx does not 
generate this error no matter how much pressure I put on them. I've 
found a lot of scuttlebutt regarding these problems with sshd on the 
net, but this appears a hardware/driver problem.  There's mention of a 
specific problem with e1000 here: 
http://www.psc.edu/networking/projects/hpn-ssh  but no apparent resolution.

Any suggestions are greatly appreciated.

-E
