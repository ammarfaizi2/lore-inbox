Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUBYB7C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUBYB7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:59:01 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:1510 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262356AbUBYB6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:58:46 -0500
Message-ID: <403C014F.2040504@blue-labs.org>
Date: Tue, 24 Feb 2004 20:58:39 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       albert@users.sourceforge.net
Subject: /proc or ps tools bug?  2.6.3, time is off
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.3, procps 3.2.0

# while [ 1 ]; do (ps aux|grep "grep ps aux" && date) ; sleep 1; done
root     20043  0.0  0.0  1504  456 pts/0    R    20:45   0:00 grep grep 
ps aux
Tue Feb 24 20:45:25 EST 2004
root     20062  0.0  0.0  1504  460 pts/0    S    20:45   0:00 grep grep 
ps aux
Tue Feb 24 20:45:26 EST 2004
root     20081  0.0  0.0  1504  460 pts/0    S    20:46   0:00 grep grep 
ps aux
Tue Feb 24 20:45:27 EST 2004

Note the change in the timestamp as reported by 'ps' v.s. the time 
reported by 'date'.

Repeatable every time at 26 seconds after the minute +/- a portion of a 
second.

David

