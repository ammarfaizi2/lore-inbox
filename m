Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVB1AaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVB1AaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVB1AaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:30:12 -0500
Received: from www.rapidforum.com ([80.237.244.2]:41374 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261254AbVB1AaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:30:05 -0500
Message-ID: <42226607.6020803@rapidforum.com>
Date: Mon, 28 Feb 2005 01:29:59 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
References: <4221FB13.6090908@rapidforum.com> <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com> <422239A8.1090503@rapidforum.com> <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com> <42225B34.7020104@rapidforum.com> <Pine.LNX.4.61.0502271905270.19979@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0502271905270.19979@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already tried with 300 KB and even used a perl-hash as a horrible-slow buffer for a 
readahead-replacement. It still slowed down on the syswrite to the socket. Thats the strange thing.

Rik van Riel wrote:
> On Mon, 28 Feb 2005, Christian Schmid wrote:
> 
> 
>>No i am only using 4 tasks with Poll-API and non-blocking sockets. Every
>>socket gets a 1 MB read-ahead. This are 4000 MB Max on a 8 GB machine....
>>Shouldnt thrash.
> 
> 
> If nothing else on the system uses any memory, and there
> were no memory zones and no division into active and
> inactive memory.
> 
> You may want to try a smaller readahead window and see if
> your system still has trouble with the load.
> 
