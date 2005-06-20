Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFTOuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFTOuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVFTOuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:50:19 -0400
Received: from [202.125.86.130] ([202.125.86.130]:16105 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261260AbVFTOuJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:50:09 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: how to insert an asm instruction in C code and how to compile it
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 20 Jun 2005 20:28:26 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348115AB385@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to insert an asm instruction in C code and how to compile it
Thread-Index: AcV1pHyGUPRcEsqnTImMy0FsgGrfwQAAENZw
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I am very sorry for asking such a silly question here.

I have small doubt about ASM code in a C program. Actually I want to
insert some asm instructions in a C program and after that I want to
compile the C program. 

I want to include the following code in a simple C program and compile
it.

#define printf DbgPrint

int main()
{
	printf("Hello world program!\n");
	return 0;
}
void DbgPrint(char* str,...)
{
	volatile USHORT i = 0;
    	volatile UCHAR sch;
	while(str[i])
	{
		sch = str[i];
		i ++;
		asm mov ah,0x0E;
		asm mov al,sch;
		
		asm cmp	al,0ah 
		asm jne	test
		asm mov	al,0dh     //; new line
		asm mov	bx,07h
		asm int	10h
		asm mov	al,0ah
test:
		asm mov bx,0x07
		asm int 0x10
	}
}

Please let me know how to do it?

Any links or Howtos are welcome.
Thanks in advance.

Regards,
Srinivas G
