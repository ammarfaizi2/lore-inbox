Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTD3Tpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbTD3Tpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:45:46 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:5760 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S262375AbTD3Tpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:45:42 -0400
Message-ID: <20030430195748.18712.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Thu, 01 May 2003 03:57:48 +0800
Subject: [BUG ? in 2.5.68] time and sleep...
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I dunno if what I'm reporting is a real problem or not...
I was playing with both the time and sleep command,
I wrote a simple script like the following

for i in `seq 1 1 600`;
do
	time sleep 1
done;

Then I've run it in background and then I've run 'dbench 32'.

As soon as dbench finis its work I've killed the process in background.

The script was redirected to a file,
this is the result of a simple cat file.txt|grep elapsed|cut -d " " -f 3

0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.16elapsed <-
0:02.84elapsed <-
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.48elapsed <-
0:04.86elapsed <-
0:01.00elapsed
0:01.02elapsed
0:01.02elapsed
0:01.00elapsed
0:01.02elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.01elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.01elapsed
0:01.00elapsed
0:01.00elapsed
0:01.01elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.03elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.02elapsed
0:01.01elapsed
0:01.00elapsed
0:01.55elapsed <-
0:01.02elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.02elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.06elapsed
0:01.02elapsed
0:01.00elapsed
0:01.04elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.19elapsed <-
0:01.00elapsed <-
0:02.46elapsed <-
0:01.27elapsed <-
0:01.03elapsed <-
0:01.07elapsed <-
0:08.20elapsed <-
0:02.88elapsed <-
0:09.24elapsed <-
0:01.00elapsed
0:05.11elapsed <-
0:07.08elapsed <-
0:10.69elapsed <-
0:03.06elapsed <-
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
0:01.00elapsed
[...]

So in a few cases sleep 1 seems to last for a few seconds.

Is it OK ?

Kernel is 2.5.68 preemption on.

Ciao,
	Paolo
	

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
