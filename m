Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVFJP1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVFJP1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVFJP1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:27:25 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:20722 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S262574AbVFJP1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:27:19 -0400
Message-ID: <42A9B193.1020602@stud.feec.vutbr.cz>
Date: Fri, 10 Jun 2005 17:28:19 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alastair Poole <alastair@unixtrix.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
References: <42A8ABDB.6080804@unixtrix.com>
In-Reply-To: <42A8ABDB.6080804@unixtrix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Poole wrote:
> I have tested various kernels including 2.6.11.10 2.6.11.11 and 
> 2.6.12-rc6 and am having unusual results regarding connect().  Earlier 
> kernels do not return the same strange results.

What is the last version that works as expected for you?

> I have tested numerous basic port scanners, including my own, and 
> strangely ports which are NOT open are being reported as open.  I have 
> checked these ports by various means -- to be certain they are NOT open 
> -- and in various runlevels; the results are the same.
> 
> The number of ports listed changes in size and they appear to be 
> random.  For example, on one scan ports 22, 3455, 4532 and 6236 will 
> appear open; on another scan it might be 22, 3567, 3879, 3889, 6589 and 
> 7374.
> However, ports which ARE open do also appear as open alongside these 
> "rogue" ports.  I have also tested this on another system with the same 
> results.  It is also interesting to note that a basic TCP nmap scan does 
> not return these unusual results.

Are you testing your scanner only on localhost? Maybe you are just lucky 
and connect your TCP socket to itself.

> Enclosed is example code that produces these results on the named 
> kernels and systems.
> [...]
> int
> main (int argc, char **argv)
> {
>  int sd, result, server_port;
>  *struct* hostent *he;
>  *struct* sockaddr_in servaddr;

What are these asterisks doing there? Next time when you copy&paste 
code, please make sure you don't mangle it.

Michal
