Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUCKQCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUCKQBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:01:51 -0500
Received: from smtp.irisa.fr ([131.254.130.26]:61877 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S261437AbUCKQBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:01:45 -0500
Message-ID: <40508D65.9000601@irisa.fr>
Date: Thu, 11 Mar 2004 17:01:41 +0100
From: David Fort <david.fort@irisa.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unkillable Zombie process under 2.6.3 and 2.6.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
i have some troubles with some totally unkillable zombie process:
Here's how i can get unkillable zombies debug multi-threaded program 
using gdb and
in the execution my program popens a command, sometimes i get the 
following gdb message

waiting for new child: No child processes.
(gdb)

And gdb give me back the prompt. I have the impression that the child 
process has
been effectively launched.
If i ask gdb to continue the process goes on but the incriminated thread 
looks freezed. When
in this state i can contact other threads, but gdb is stuck(Ctrl+C 
doesn't work).

Killing -9 my program doesn't have any effect. But killing -9 gdb 
effectivelly kills gdb
but not my program(which is a son of gdb). Shouldn't the kernel finish 
the job with zombie
process when their father die ?(there's nobody to catch signals, or 
return codes).

My big problem is that the faulty program keeps its binding sockets 
opened, so i can't
launch anything on that ports.

-- 
Fort David, Projet IDsA
IRISA-INRIA, Campus de Beaulieu, 35042 Rennes cedex, France
Tél: +33 (0) 2 99 84 71 33


