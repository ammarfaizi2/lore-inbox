Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270003AbRHETly>; Sun, 5 Aug 2001 15:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269824AbRHETlp>; Sun, 5 Aug 2001 15:41:45 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2822 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269999AbRHETln>;
	Sun, 5 Aug 2001 15:41:43 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kaih@khms.westfalen.de (Kai Henningsen)
cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC? (Was: Re: [RFC] /proc/ksyms change for IA64) 
In-Reply-To: Your message of "05 Aug 2001 11:29:00 +0200."
             <86HgALWHw-B@khms.westfalen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 05:41:47 +1000
Message-ID: <29464.997040507@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Aug 2001 11:29:00 +0200, 
kaih@khms.westfalen.de (Kai Henningsen) wrote:
>kaos@ocs.com.au (Keith Owens)  wrote on 02.08.01 in <22165.996722560@kao2.melbourne.sgi.com>:
>
>> The IA64 use of descriptors for function pointers has bitten ksymoops.
>> For those not familiar with IA64, &func points to a descriptor
>> containing { &code, &data_context }.
>
>That sounds suspiciously like what I remember from PPC. How is this solved  
>on the PPC side?

Best guess, without access to a PPC box, is that it is not solved.  Any
arch where function pointers go via a descriptor will have this
problem.

PPC users, does /proc/ksyms contain the address of the function code or
the address of a descriptor which points to the code?  It is easy to
tell, if function entries in /proc/ksyms are close together (8-128
bytes apart) and do not match the addresses in System.map then PPC has
the same problem as IA64.  If this is true, what is the layout of a PPC
function descriptor so I can handle that case as well?

