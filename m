Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVETJa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVETJa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVETJa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:30:26 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:1292 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261399AbVETJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:30:18 -0400
Message-ID: <428DAF67.70105@aitel.hist.no>
Date: Fri, 20 May 2005 11:35:35 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sylvanino b <sylvanino@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: questions about system function: mmap / fwrite
References: <d14685de050520021439e48c8d@mail.gmail.com>
In-Reply-To: <d14685de050520021439e48c8d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sylvanino b wrote:

>Hello,
>
>I have a question about ways of accessing a file. 
>
>I know it is possible to use: fseek + fwrite/fread to access a file.
>and It is also possible to map file in memory with  "mmap" function,
>and access it by adressing memory.
>
>Currently I use the frame buffer of  mobile phones with mmap function.
>For my understanding, I would like to know what is the difference
>between using fseek+fwrite compared to mmap style.
>Dont hesitate to be precise or to use technical terms.
>
>Thanks you,
>  
>
There may be subtle performance differences, but I'd say the most
important here is to use the API that best suits the problem at hand.
fwrite/fread is sequential in nature, useful when you want to read/write
large contigous chunks of data, and when the notion of a "current position"
in the file is useful.

mmap is nice when you find it useful to access the file as a random-access
array of bytes. mmap style access seems to be the best fit for a 
framebuffer.

Helge Hafting

Helge Hafting

