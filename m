Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTJASGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTJASGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:06:50 -0400
Received: from imr2.ericy.com ([198.24.6.3]:3821 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S263161AbTJASGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:06:43 -0400
Message-ID: <3F7B1987.3050104@ericsson.ca>
Date: Wed, 01 Oct 2003 14:14:31 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification
 for binaries
References: <3F733FD3.60502@ericsson.ca> <20031001102631.GC398@elf.ucw.cz> <3F7AD795.1040001@ericsson.ca> <20031001141718.GT7665@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Wed, Oct 01, 2003 at 09:33:09AM -0400, Makan Pourzandi wrote:
> 
>  
>
>>Third, the intruder now has access to the system, he cannot execute the 
>>code he brought in with himself (not signed) or he cannot bring it in 
>>(c.f. above). So he needs to compile the code on the system. AFAIK, for 
>>the absolute majority of servers the admins remove all compilers 
>>(specially gcc) on all servers. this is for several different security 
>>reasons  (I don't want to get there). therefore, the above hypothesis 
>>gets even more difficult to realize. 
>>    
>>
>
>Don't be ridiculous.  It's trivial to exploit a local buffer overrun in
>one of your signed binaries and have the shellcode mmap the rest.  All
>pre-built, of course.
>  
>

Hi Viro,

Obviously, I failed to show that the main functionality of digsig is to 
avoid the execution of __normal__ rootkits, Trojan horses and other 
malicious binaries on your system. 

the above was to analyze an imaginary scenario. well, you bring a new 
scenario than the mmap is used from a shell code. well, in this 
scenario, digsig makes it difficult for the intruder to bring his own 
rootkit and run it. i mean, yes he could decide to reboot your system or 
remove all your files or ..., and digsig is not going to help here, it 
isn't its job either !   
Back to the subject, in the first 2 points of my previous email, I tried 
to show that the use of digsig make it difficult for the intruder to 
bring in the malicious binaries, __then and only then__ at last 
resource, to be able to use mmaps, he can choose to compile the code 
locally.  

Once again,  the purpose here is neither to secure system against all 
possible attacks nor to avoid all possible scenarios; digsig is not  
going to avoid you buffer overflows or other vulnerabilities. BTW, there 
are tools to avoid that to happen (c.f. Pax, Exec Shield...).  the 
purpose here is to make it more difficult for the intruder to abuse the 
system. if there is a remote exploit in your system, the intruder can 
use it. however, i believe, as i explained in first 2 points of the 
previous email, digsig  makes it much more difficult for the intruder to 
bring in his rootkit and use it, same for the excution of Trojan horses 
or backdoor programs.

On the other hand, you're right if the people begin to write these 
shellcode mmaps, this is a problem that we have to solve. however, my 
understanding of the state of the art on malware today is that we don't 
have many of these "shellcode mmap" exploits. generally, many of the 
exploits use classical rootkits which still use exec for executing their 
binaries.

regards,
makan

