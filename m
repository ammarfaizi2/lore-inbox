Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVB1NOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVB1NOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVB1NOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:14:15 -0500
Received: from imag.imag.fr ([129.88.30.1]:65227 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261583AbVB1NOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:14:09 -0500
Message-ID: <1109596437.422319158044b@webmail.imag.fr>
Date: Mon, 28 Feb 2005 14:13:57 +0100
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 14:14:00 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Mon, Feb 28, 2005 at 01:57:59PM +0100, colbuse@xxxxxxxxxxxxxxx wrote:
>> Please _don't_ apply this, but tell me what you think about it.

>It's broken. 8)

>> --- old/drivers/char/vt.c 2004-12-24 22:35:25.000000000 +0100
>> +++ new/drivers/char/vt.c 2005-02-28 12:53:57.933256631 +0100
>> @@ -1655,9 +1655,9 @@
>> vc_state = ESnormal;
>> return;
>> case ESsquare:
>> - for(npar = 0 ; npar < NPAR ; npar++)
>> + for(npar = NPAR-1; npar < NPAR; npar--)

>How many times do you want this for loop to run?


NPAR times :-). As I stated, npar is unsigned.


See : 
$cat x.c
#include <stdio.h>
#define NPAR 5

int main(void){
        unsigned int i;
        int j=0;
        for(i=NPAR-1;i<NPAR;i--) j++;
        fprintf(stdout,"it has runned %d times :-)\n",j);
}

$gcc x.c -o x && ./x
it has runned 5 times :-)
$

--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement telecoms

-------------------------------------------------
envoyé via Webmail/IMAG !

