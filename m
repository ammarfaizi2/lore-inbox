Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316172AbSEZPkR>; Sun, 26 May 2002 11:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316175AbSEZPkQ>; Sun, 26 May 2002 11:40:16 -0400
Received: from mail7.svr.pol.co.uk ([195.92.193.21]:6681 "EHLO
	mail7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316172AbSEZPkQ>; Sun, 26 May 2002 11:40:16 -0400
Posted-Date: Sun, 26 May 2002 15:39:18 GMT
Date: Sun, 26 May 2002 16:39:12 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <20020526172810.A19405@ucw.cz>
Message-ID: <Pine.LNX.4.21.0205261635080.15697-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech, Martin.

>> Would the following be what you had intended?
>>
>>	#include <linux/io.h>
>>	#include <stdio.h>
>>	#include <stdlib.h>
>>
>>	int main(int argc, char **argv) {
>>	    int byte, port, result = 0;
>> 
>	    iopl(3);
>>	    switch (argc) {
>>		case 2:
>>		    port = atoi(argv[1]);
>>		    result = inb(port);
>>		    break;
>>
>>		case 3:
>>		    port = atoi(argv[1]);
>>		    byte = atoi(argv[2]);
>>		    outb(port, byte);
>>		    break;
>>
>>		default:
>>		    fprintf(stderr, "Usage: %s port [byte]\n",
>>			    argv[0]);
		    result = -1;
>>		    break;
>>	    }
	    exit(result);
>>	}

Wonder how many bugs are left now those two have been squished...

Best wishes from Riley.

