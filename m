Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263261AbTCYTDz>; Tue, 25 Mar 2003 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263264AbTCYTDz>; Tue, 25 Mar 2003 14:03:55 -0500
Received: from imr1.ericy.com ([208.237.135.240]:36225 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S263261AbTCYTDy>;
	Tue, 25 Mar 2003 14:03:54 -0500
From: "Philippe Meloche (LMC)" <Philippe.Meloche@ericsson.ca>
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <3E80AAF2.6090301@lmc.ericsson.se>
Date: Tue, 25 Mar 2003 14:16:02 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Epoll + ephttpd2.0 + Coro
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to run the ephttpd 2.0 server on a PII with a 2.4.19 kernel 
patched with /dev/epoll.  But I have trouble with the coro ( C 
couroutine ) library.  The server always does a segmentation fault when 
the function dph_exit_conn() calls co_exit(0). It's the fatal() function 
that generates this segmentation fault. Plus, this fault is 
automatically generated each time there is no more requests on a 
connection and that dph_httpd() calls dph_exit_conn().

I would like to know of you ever had this kind of problem and how you 
solved it. The version of coro I use is the 1.1.0-pre2. I need this http 
server to rebuild /dev/epoll tests on my computer for reference results.

Philippe Meloche

Philippe.Meloche@lmc.ericsson.se
