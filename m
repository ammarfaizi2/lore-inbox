Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVFJQFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVFJQFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVFJQFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:05:35 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:1217 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S262591AbVFJQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:05:30 -0400
Message-ID: <42A9BA87.4010600@stud.feec.vutbr.cz>
Date: Fri, 10 Jun 2005 18:06:31 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alastair Poole <alastair@unixtrix.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
References: <42A8ABDB.6080804@unixtrix.com> <42A9B193.1020602@stud.feec.vutbr.cz> <42A9C607.4030209@unixtrix.com>
In-Reply-To: <42A9C607.4030209@unixtrix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Poole wrote:
> This problem only occurs on localhost.  I don't think it is mere luck, 
> these are too frequent and strange for this.

I tried the scanning program on localhost. I modified it to wait for the 
user to press Enter when it encounters an open port.
On my system I normally have listening TCP ports 25, 631 and 1024.
And yes, the scanning program sometimes finds other open ports.
This is netstat output when it happens:

michich@michichnb:~> LC_ALL=C netstat -ntp | grep scan
(Not all processes could be identified, non-owned process info
  will not be shown, you would have to be root to see it all.)
tcp  0  0  127.0.0.1:1774   127.0.0.1:1774     ESTABLISHED 17510/scan


The TCP socket connected to itself. I don't know if it's expected 
behaviour. It agree it is strange, because we didn't call listen() on 
the socket.

Michal
