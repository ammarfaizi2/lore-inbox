Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTBEVyC>; Wed, 5 Feb 2003 16:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTBEVyC>; Wed, 5 Feb 2003 16:54:02 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:64214 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264954AbTBEVyB>; Wed, 5 Feb 2003 16:54:01 -0500
Message-ID: <3E418A32.2010308@nortelnetworks.com>
Date: Wed, 05 Feb 2003 17:03:30 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about creating char device in 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A coworker of mine had created a character device for 2.2 and is now 
looking into porting it forward to 2.4 but he's running into some issues 
with the new generic io code.

Basically he impemented a virtual device that had a fixed amount of 
buffer space.  You could write to/read from that storage space as usual, 
with the one exception that once it was full you could continue to write 
to it and the writes would succeed.

Basically the ideas was to create something that you could log to and 
only the first x bytes would be logged.  After that the writes would 
still succeed but the data would be thrown away. "cat"ing the file would 
then give you the first x bytes that had been stored.

How would you go about hooking in to the 2.4 char device code to do 
something equivalent?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

