Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTEFBBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTEFBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:01:47 -0400
Received: from adsl-216-103-89-123.dsl.snfc21.pacbell.net ([216.103.89.123]:38919
	"HELO mail.vividlogic.com") by vger.kernel.org with SMTP
	id S262228AbTEFBBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:01:46 -0400
Message-ID: <3EB70FBC.7070105@vividlogic.com>
Date: Mon, 05 May 2003 18:28:28 -0700
From: Manu Prasad <manu@vividlogic.com>
Organization: VividLogic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question on  thread priorities in Linux
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding thread priorities in Linux.

The scenario is like this:
I have a thread 'A' in the Kernel which services external requests and 
has to respond within a specified time(generally in milli secs).

I have some compute intensive calculation being done in the UserLevel 
for which data is made available from the kernel. So I have a user 
thread 'B' which blocks in the kernel, by making an IOCTL call, to 
collect the data and service the compute intensive calculation when a 
request comes. This calculation can take anywhere from 3-6 secs. After 
calculation is completed in the UserLevel it passes the result of the 
calculation by another IOCTL to the Kernel.

My problem is:

The kernel thread 'A' generally services requests within the stipulated 
time(some milli secs). But sometimes when the request arrives during the 
compute intensive calculation in the <<User Level the service is not 
rendered in the stipulated time>> and sometimes take as long as the 
actual completion of the compute intensive calculation(3-6 secs).
Isn't it that the Kernel thread preempts the UserLevel thread?

I am using linux 2.4.17.
Thanks for your help,
-Manu
PS: Could you please CC me the answer to this question.

