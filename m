Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTJFPGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJFPGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:06:55 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:61150 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262182AbTJFPGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:06:54 -0400
Message-ID: <3F818505.3010801@nortelnetworks.com>
Date: Mon, 06 Oct 2003 11:06:45 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tushar Telichari <tushar@versant.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Shared memory problem
References: <Pine.LNX.4.21.0310061244540.20274-100000@dahlia.vipl.versant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tushar Telichari wrote:
> Hi,
> 
> I have a process which requires about 1G of shared memory.
> There are multiple processes which are going to share this.
> I am able to allocate this by setting shmmax..etc. 

Your other option would be to create it as a file in the filesystem and 
then mmap it.  If you create a tmpfs filesystem and then mmap a file on 
it there will be no real file on disk.  If you create it on disk and 
mmap it, then you have the option of persistant storage is that is 
desirable.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

