Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSKLQAF>; Tue, 12 Nov 2002 11:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSKLQAF>; Tue, 12 Nov 2002 11:00:05 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45518 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261854AbSKLQAD>; Tue, 12 Nov 2002 11:00:03 -0500
Message-ID: <3DD12714.30300@nortelnetworks.com>
Date: Tue, 12 Nov 2002 11:06:44 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Voigt wrote:
> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, and neither the cp or the
> mv command will work, they both same "argument list too long" when I
> use:
> 
> cp -f * /usr/local/www/images
> 
> or
> 
> mv -f * /usr/local/www/images
> 
> Is this a kernel limitation?

It's not a kernel limitiation, its a shell limitation.  "*" expands to 
the list of 39000 names, which is too large.


You could try something like:

ls .|xargs cp -f --target-directory=/usr/local/www/images


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

