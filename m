Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFCWxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFCWxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFCWxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:53:35 -0400
Received: from CPE000625dddb50-CM000a73996061.cpe.net.cable.rogers.com ([70.28.15.40]:13901
	"EHLO deimos.masoud.ir") by vger.kernel.org with ESMTP
	id S261164AbVFCWxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:53:33 -0400
Message-ID: <42A0DF51.2010809@axentra.net>
Date: Fri, 03 Jun 2005 15:53:05 -0700
From: Masoud Sharbiani <masouds@axentra.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: riel@surriel.com
CC: linux-kernel@vger.kernel.org
Subject: rmap patches for 2.4.30(or 31)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

It seems that I have successfully hacked 2.4.25 rmap patch so that it 
applies cleanly to 2.4.30 (that is, it compiles, boots and runs great 
under normal conditions); How would I go for testing it and stress 
testing it? It does survive the make -j of kernel (with lots of swap), 
but, when I want to try and run ltp tests, it goes to a bad mood (i.e. 
swapping out massively at first, then a dead silence)

Here is my ltp test run command:
./runltplite.sh -i 1024 -m 128 -p -q -l /tmp/result-rmap -d /home/0tmp/
It ends up forking a lot of loadgen processes that simply allocate 
memory and use it (and CPU), so the system becomes unresponsive; It also 
starts killing processes since it runs out of memory. I don't see any 
hangs or panics, and the system responds to pings and Keyboard dump 
commands, such as right-Alt+Scroll lock and similar ones, and looks it 
is spending most of its time in page_launder() or thereabouts, swap and 
physical memory both become full.
How do you test the rmap patches for correctness before offering them to 
the people out there?
The patch is available from http://masoud.ir/patches/2.4.30-rmap15.patch

Thanks in advance,
Masoud Sharbiani

