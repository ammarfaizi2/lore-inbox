Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUIOPNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUIOPNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIOPNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:13:17 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:40268 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266311AbUIOPNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:13:06 -0400
Date: Wed, 15 Sep 2004 11:15:07 -0400
From: Andre Bonin <kernel@bonin.ca>
Subject: Re: PCI coprocessors
In-reply-to: <Pine.LNX.3.96.1040915164509.26011A-100000@pioneer.space.nemesis.pl>
To: Tomasz Rola <rtomek@cis.com.pl>
Cc: linux-kernel@vger.kernel.org
Message-id: <41485C7B.40202@bonin.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <Pine.LNX.3.96.1040915164509.26011A-100000@pioneer.space.nemesis.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2)
 Gecko/20040803
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for all your input on this.  Of course i could do many things 
on the board.  The idea of the library is that a programmer would create 
the fpga image file by him/herself and then put it in the library.  The 
kernel driver and the library does the decision if its worth putting on 
the chip or not (that's optional, you could force it on chip).

Tomasz Rola wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>  
>
>>Which leads me to my questions:
>>
>>1) Is their support for having two different 'machine types' within one 
>>kernel? that is for example, certain executables for intel would get run 
>>on an intel processor, and others would get run on processor with type XXXX.
>>    
>>
>
>There are probably no impossible things - some may be unthinkable but once
>they are thought of, they can be done too. But this one thing may be
>rather difficult (just my opinion).
>  
>
Yes i think so too, especially since it will be my first kernel module 
(and anxiously waiting the next release of the o'reilly book for 
refference).

>How about porting kernel and gcc to your fp-cpu and use pci as a
>kind of fast network-like interconnect? After loading a kernel into it
>somehow, boot it with nfs root and run the rest from nfs server that would
>be provided by a host Intel machine.
>  
>
System-on-chips have been done before, and could be integrated into the 
kernel like you said.  But RAM becomes a problem.  Since its only a 
student project, we have a limit on the adressing width for the ram 
(32bit addressing becomes 32 wires, that's a lot of wirewraping :)  ).

>That would require less changes to a kernel, probably. A module for a
>host, for example - some "pci-net". And port of a kernel to your fp-cpu
>which should be easier than putting support for heterogenous
>multiprocessors...
>  
>

I agree but i think that goes beyond the scope of the project.  Though i 
will consider it.  Thanks for your input!

>- --
>** A C programmer asked whether computer had Buddha's nature.      **
>** As the answer, master did "rm -rif" on the programmer's home    **
>** directory. And then the C programmer became enlightened...      **
>**                                                                 **
>** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **
>
>-----BEGIN PGP SIGNATURE-----
>Version: PGPfreeware 5.0i for non-commercial use
>Charset: noconv
>
>iQA/AwUBQUhX/xETUsyL9vbiEQKAlACg9Rv6rD8INCQFItk1/s5OfZbXjukAn2Mp
>PGjv6ihFXwTInSn8nu3ZOKpu
>=E5XU
>-----END PGP SIGNATURE-----
>
>
>
>
>  
>

