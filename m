Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTEISm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTEISmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:42:06 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:54420 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263286AbTEISl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:41:58 -0400
Message-ID: <3EBBF965.4060001@nortelnetworks.com>
Date: Fri, 09 May 2003 14:54:29 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: anyone ever implemented a reparent(pid) syscall?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got some other developers wanting some way for a process to be notified on 
the death of another process.  Now I understand that if all the processes are 
forked by a main one, then the main one will get a SIGCHILD on the death of the 
other processes.

The problem with this is that if the main one dies, then all the other ones get 
reparented to init.  I would like some way for the main one to restart, read the 
list of pids out of a file that it conveniently stashed away, and reparent the 
pids back to itself (the same way that they were reparented to init in the first 
place) so that it gets SIGCHILD when they die.

Once I have this ability, then it becomes simple for arbitrary processes to 
register with it so that others can be notified in some standard way if they die.

Has anyone ever done this?  Is there any reason why it is a particularly bad idea?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

