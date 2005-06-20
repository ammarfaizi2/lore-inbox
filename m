Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFTO6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFTO6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVFTO6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:58:13 -0400
Received: from panther.mmj.dk ([62.79.83.143]:42481 "EHLO panther.mmj.dk")
	by vger.kernel.org with ESMTP id S261277AbVFTO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:57:53 -0400
Date: Mon, 20 Jun 2005 16:57:52 +0200
From: Mads Martin Joergensen <mmj@mmj.dk>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: how to insert an asm instruction in C code and how to compile it
Message-ID: <20050620145752.GB27543@mmj.dk>
Mail-Followup-To: Mads Martin Joergensen <mmj@mmj.dk>,
	"Srinivas G." <srinivasg@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <4EE0CBA31942E547B99B3D4BFAB348115AB385@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348115AB385@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Srinivas G. <srinivasg@esntechnologies.co.in> [Jun 20. 2005 16:52]:
> I am very sorry for asking such a silly question here.
> 
> I have small doubt about ASM code in a C program. Actually I want to
> insert some asm instructions in a C program and after that I want to
> compile the C program. 
> 
> I want to include the following code in a simple C program and compile
> it.
> 
> #define printf DbgPrint
> 
> int main()
> {
> 	printf("Hello world program!\n");
> 	return 0;
> }
> void DbgPrint(char* str,...)
> {
> 	volatile USHORT i = 0;
>     	volatile UCHAR sch;
> 	while(str[i])
> 	{
> 		sch = str[i];
> 		i ++;
> 		asm mov ah,0x0E;
> 		asm mov al,sch;
> 		
> 		asm cmp	al,0ah 
> 		asm jne	test
> 		asm mov	al,0dh     //; new line
> 		asm mov	bx,07h
> 		asm int	10h
> 		asm mov	al,0ah
> test:
> 		asm mov bx,0x07
> 		asm int 0x10
> 	}
> }
> 
> Please let me know how to do it?

http://www.int80h.org/

-- 
Mads Martin Joergensen, http://mmj.dk
"Why make things difficult, when it is possible to make them cryptic
 and totally illogical, with just a little bit more effort?"
                                -- A. P. J.
