Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSKHGhp>; Fri, 8 Nov 2002 01:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbSKHGhp>; Fri, 8 Nov 2002 01:37:45 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:31887 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266761AbSKHGhp>; Fri, 8 Nov 2002 01:37:45 -0500
Message-ID: <3DCB5D22.3070701@nortelnetworks.com>
Date: Fri, 08 Nov 2002 01:43:46 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Colin Burnett <cburnett@fractal.candysporks.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: pure raw eth sockets
References: <1036735964.3dcb55dc6f784@www.candysporks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Burnett wrote:

> socket(PF_INET, SOCK_PACKET, ETH_P_RARP)

I believe you want something more like:

socket(PF_PACKET, SOCK_RAW, htons(ETH_P_RARP));

Try doing a man on "packet".

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

