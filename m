Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291222AbSAaSdu>; Thu, 31 Jan 2002 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291221AbSAaSdl>; Thu, 31 Jan 2002 13:33:41 -0500
Received: from [63.204.6.12] ([63.204.6.12]:4596 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S291218AbSAaSd2>;
	Thu, 31 Jan 2002 13:33:28 -0500
Message-ID: <3C598DE3.8090405@somanetworks.com>
Date: Thu, 31 Jan 2002 13:33:07 -0500
From: "Deepinder Singh" <dsingh@somanetworks.com>
Organization: Somanetworks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory leaks with GRE Tunnels 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I have been doing some testing using GRE tunnels in Linux ( which btw 
work great ). I found that creating and deleting a tunnel results in a 
memory leak.

To test it out I wrote a small script that basically loops around 
creating and then deleting 8000 tunnel interfaces at a time. On the 
eighth iteration  the system hangs a whole with no error messages. There 
  was still enoungh virtual memory around even with the leaks so I 
figured something else is wrong. It turns out that the interface numbers 
( as seen in ' ip link ls' )  do not seem to be reused when an interface 
is deleted and as such the system hangs when the number reaches 64K.

I suspect the two issues are realted but am more of a cisco guy and know 
kernel internals. The total mem leak for the 64 K tunnels is about 200 megs.

Please cc me if you reply to this post as I am not on the list.

thanks,
Deepinder Singh
Sr. Network Eng.
Soma Networks

