Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSEZP2X>; Sun, 26 May 2002 11:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316170AbSEZP2W>; Sun, 26 May 2002 11:28:22 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:3259 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316167AbSEZP2V>;
	Sun, 26 May 2002 11:28:21 -0400
Date: Sun, 26 May 2002 17:28:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Riley Williams <rhw@InfraDead.Org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020526172810.A19405@ucw.cz>
In-Reply-To: <3CEBC496.9030900@evision-ventures.com> <Pine.LNX.4.21.0205260915330.29968-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 02:53:37PM +0100, Riley Williams wrote:

> Would the following be what you had intended?
> 
> 	#include <linux/io.h>
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 
> 	int main(int argc, char **argv) {
> 	    int byte, port, result = 0;

	    iopl(3);
> 
> 	    switch (argc) {
> 		case 2:
> 		    port = atoi(argv[1]);
> 		    result = inb(port);
> 		    break;
> 
> 		case 3:
> 		    port = atoi(argv[1]);
> 		    byte = atoi(argv[2]);
> 		    outb(port, byte);
> 		    break;
> 
> 		default:
> 		    fprintf(stderr, "Usage: %s port [byte]\n", argv[0]);
> 		    break;
> 	    }
> 	    return result;
> 	}

-- 
Vojtech Pavlik
SuSE Labs
