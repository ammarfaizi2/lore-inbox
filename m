Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSGIQh4>; Tue, 9 Jul 2002 12:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGIQhz>; Tue, 9 Jul 2002 12:37:55 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:54739 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S316679AbSGIQhx>; Tue, 9 Jul 2002 12:37:53 -0400
Message-ID: <3D2B11FA.65A92E40@nortelnetworks.com>
Date: Tue, 09 Jul 2002 12:40:26 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recoverable RAM Disk
References: <200207091619.RAA00228@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pipex.com wrote:
> 
> Just wondering - has anyone ever given any thought to the idea of a RAM disk that is not erased on a warm boot?
> 
> Obviously this is a bit architechture-specific - I don't think it's easily do-able on i386, but maybe it is other architechtures?

We did it for a product using PowerPC on compactPCI.  Critical logs are stored
in ram beyond what the kernel uses, and it can be mapped in for processes to use
it.

As long as the card has power, the information remains available, including
resets of the card.

The only tricky bit is that I don't know if a warm boot on a PC wipes ram or
not...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
