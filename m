Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUEXO7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUEXO7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUEXO7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:59:19 -0400
Received: from mx2.datanet.hu ([194.149.13.163]:33293 "EHLO mx2.datanet.hu")
	by vger.kernel.org with ESMTP id S264212AbUEXO7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:59:17 -0400
Message-ID: <40B211A3.3010904@flexys.hu>
Date: Mon, 24 May 2004 17:15:47 +0200
From: Tibor Kendl <kendl@flexys.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.3) Gecko/20030312
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A question about disk-cacheing
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list members in linux-kernel!

I had the following experiences with linux network file system clients. 
Under Intel P4 machine, Linux Debain Sarge distribution and Linux-2.6.5 
kernel i tried to use a Novell Server shrared volumes, and i used the 
ncpfs package for this purpose. This ncpfs package works very good, i 
can read/write Novell's shared directories from my linux host, in a 
10-12 user intra network with 2-4 MB/sec. I have a database application 
which stores it's data in files, instead of an SQL or any type of 
database servers. When i store that files in a Novell file server, that 
application is very slow. I set up an another linux box with a Samba 
file server, and tested that with the same data files and in this case 
it run 6-8 times faster than with Novell/ncpfs client. I've spied the 
communication between client/server with network performance monitors, 
and it had been found out that the  ncpfs client have 6-8 times bigger 
network traffic than the smbfs client. It seems to me that smbfs caches  
the files and this makes it's network traffic much less than on the 
other case. The mount option sync and async had no effect on ncpmount. 
My question is:
Who is responsible for file caching? The linux kernel, the kernel 
filesystem drivers, or something else? Does file caching works different 
on a local ext2,reiser and on a network nfs,smbfs,ncpfs file system?

Yours Faithfully!
Tibor Kendl


