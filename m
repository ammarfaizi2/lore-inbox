Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSHGN7L>; Wed, 7 Aug 2002 09:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318590AbSHGN7L>; Wed, 7 Aug 2002 09:59:11 -0400
Received: from parmenides.zen.co.uk ([212.23.8.69]:16398 "HELO
	parmenides.zen.co.uk") by vger.kernel.org with SMTP
	id <S318552AbSHGN7K>; Wed, 7 Aug 2002 09:59:10 -0400
Message-ID: <3D51288F.1090808@treblig.org>
Date: Wed, 07 Aug 2002 15:02:55 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: file handles - who ate them?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I had a bad case of running out of file handles over the weekend and 
wondered:

    1) If there are any tools for trying to track down what ate them 
all.  Looking at the state of the system today I see 2541 
(allocated)/763 (used)/ 8192 (max).  I guess I'd like to know when it 
hit the peak and what the state of the system was around that time (to 
find out if it was a particular cron job etc). I can see what is using 
them now - but that isn't too much use.

   2) Why is there a file-nr-max? Is it the case that the kernel 
allocates file handles as it needs them (i.e. the 2541 above) - but 
never frees back?  Is it just as a stop to stop rogue programs taking 
all RAM? (i.e. why don't we just let the allocated amount grow as 
needed). Is there a reason I shouldn't just set this to a huge figure?

   3) Is it possible to change what happens on hitting the max 
condition? - in someways for me it would have been better if it had 
panic'd and rebooted rather than sitting there and sulking not being 
able to open files. (Getting it to log a dump of open files at this time 
would be the ideal).

(2.4.16, x86)

Dave

