Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTDNESu (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 00:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTDNESu (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 00:18:50 -0400
Received: from dialup-10.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.10]:65028
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262739AbTDNESt (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 00:18:49 -0400
Message-ID: <3E9A31FF.6030506@cyberone.com.au>
Date: Mon, 14 Apr 2003 13:58:55 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <200304131407_MC3-1-3441-57C7@compuserve.com> <1050272156.24559.4.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1050272156.24559.4.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>On Sul, 2003-04-13 at 19:03, Chuck Ebbert wrote:
>
>>  OTOH you can come up with scenarios like, say, a DBMS doing 16K page
>>aligned IO to raw devices where you might see big gains from making sure
>>those 16K chunks didn't cross a physical cylinder boundary.
>>
>
>You couldn't even tell where such boundaries exist, or what the real
>block size of the underlying media is. Cyliners are all different sizes.
>
Yes this is getting very difficult as Alan said. Its also something
that we can't do in kernel - the block io scheduler can only choose
from what it is given. I wouldn't be surprised if big databases did
try using some sorts of disk mapping systems to help optimise
their IO however.

