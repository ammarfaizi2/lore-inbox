Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVGVPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVGVPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVGVPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:06:28 -0400
Received: from web26606.mail.ukl.yahoo.com ([217.146.176.56]:54419 "HELO
	web26606.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261299AbVGVPG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:06:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e0wUGr+ydMatQ4amJ18isfyAKDBS2hYrjsdPGqbCs0Xn8zCL0NnyllJClupi5wwsm5ju5yxy8ixXofSS6ueF0Xp49wy0NyMXGs+NrZ5skay/CMz8MrBeLpOPQ5BlgZso7t0rXifgQOYDcWtWS+ekMMmnmb+n6b3dv7hLCQqrHO0=  ;
Message-ID: <20050722150625.77130.qmail@web26606.mail.ukl.yahoo.com>
Date: Fri, 22 Jul 2005 16:06:25 +0100 (BST)
From: Christos Gentsis <christos_gentsis@yahoo.co.uk>
To: jdob@ig.com.br
Cc: bernd@firmix.at
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinicius wrote:

> On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote:
[...]  
>
>>>   I have a server with 2 Pentium 4 HT processors
and 32 GB of >>RAM,     
>
> this  
>
>>> server runs lots of applications that consume lots
of memory to. >>When I stop this applications, the
kernel doesn't free memory (the  memory >>still in
use) and the server cache lots of memory (~27GB). When
I start this applications, the kernel sends  "Out of
Memory" messages and kill some random applications.
>>>   Anyone know how can I reduce the kernel cached
memory on RHEL >>3     
>
> (kernel  
>
>>> 2.4.21-32.ELsmp - Trial version)? There is a way
to reduce the >>kernel cached memory utilization?     
>
>
>  
>
>> Probably RedHat's support can answer this for RHEL
3.
>>     Bernd -- 
>> Firmix Software GmbH                  
http://www.firmix.at/ mobil: +43 664 4416156          
      fax: +43 1 7890849-55         Embedded Linux
Development and Services   
>
>
> Bernd,
>   The server runs RHEL Trial Version, without
support... for tests purpose.
>   When I compile and run the following tester
program:
> #include <stdio.h> #include <string.h> #include
<stdlib.h>
> int main (void) {        int n = 0;        char *p;
>        while (1) {                if ((p =
malloc(1<<20)) == NULL) {                       
printf("malloc failure after %d MiB\n", n);           
            return 0;                }               
memset (p, 0, (1<<20));                printf ("got %d
MiB\n", ++n);        } }
>   The server alocates lots of free memory (including
swap) to the tester program and when its finish, lots
of cached memory are freed.
>   Have someone an idea why it's happens? Or how can
I force the kernel to frees cached memory?
> Thanks again (sorry my bad eglish again!)
> Vinicius. Protolink Consultoria.  
>
i may not be a kernel expert...(i read this list to
learn and hopefully one day help ;) but i think that
your problem is not the kernel but the program...
this is the first lesson that you learn in C/C++
whatever you open you have to close it...(brackets,
parenthesis, files,etc) and whatever you take you have
to give it back(memory)...

you use maloc to take the memory but you don't free
the memory at the end... i think that if you don't
free the memory before you exit the program the system
do not free the memory ever... :D try that and see if
it works...




	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
