Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275719AbRI0AXb>; Wed, 26 Sep 2001 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275718AbRI0AXL>; Wed, 26 Sep 2001 20:23:11 -0400
Received: from mithra.wirex.com ([65.102.14.2]:40454 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S275712AbRI0AXD>;
	Wed, 26 Sep 2001 20:23:03 -0400
Message-ID: <3BB2715C.1040506@wirex.com>
Date: Wed, 26 Sep 2001 17:22:52 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <E15mNsv-0002Cv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I'm really trying to be constructive here.  There is a real licensing 
>>problem over whether binary modules are legitimate at all, and the issue 
>>is not special to LSM. I'm trying to get LSM out of the way so that the 
>>advocates of either side can fight it out without smushing LSM in the 
>>middle :-)
>>
>Yes - I agree. The question is "can you be using the LSM module" not
>the headers - since LSM is GPL and your work relies on it 
>
I'm confused as to which question Alan is asking, so I'll answer several :-)

    * "What is the licensing on the LSM module?" Crispin's pedantic
      response: there is no "the" LSM module. LSM is a patch to enrich
      the existing Linux loadable kernel module interface to allow
      access control modules. These modules do exist:
          * There is a dummy module (useful as a template) which just
            does the superuser check ("UID==0" and access is granted)
            and it is GPL'd.
          * There is a module that embodies the guts of POSIX
            capabilities, and it is GPL'd.
          * There is a port of SELinux to LSM (produced by the SELinux
            team) and it is GPL'd.
    * "Can you use the LSM interface with a non-GPL module, if you
      eschew GPL'd .h files?" Crispin's opinion: I dunnow, but the
      answer is the same as the answer for current Linux loadble kernel
      modules. If loading a module is "linking", then all modules &
      device drivers must be GPL'd.
    * "Can a non-GPL LSM module #include a GPL'd .h?" Crispin's opinion:
      I dunnow, but the answer is the same as the answer for many
      current Linux applications.  I know, this is the question Alan did
      not ask :-)

Crispin is not a lawyer/judge, so his opinion doesn't matter anyway :-)

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


