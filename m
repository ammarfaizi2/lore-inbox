Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVEKL4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVEKL4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 07:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVEKL4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 07:56:49 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.20]:43298 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261968AbVEKL4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 07:56:35 -0400
Message-ID: <4281F39F.6090504@amsat.org>
Date: Wed, 11 May 2005 13:59:27 +0200
From: Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Colin Leroy <colin@colino.net>
CC: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [2.6.12-rc4] network wlan connection goes down
References: <20050509162454.1c1c09a9@colin.toulouse>	<200505090812.49090.david-b@pacbell.net>	<20050510104349.7aca4227@colin.toulouse>	<200505100707.13356.david-b@pacbell.net> <20050511090947.581b80a4@colin.toulouse>
In-Reply-To: <20050511090947.581b80a4@colin.toulouse>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy wrote:

>I guess this zd1201_mac_reset() call is what "fixes" it.
>  
>
One of the results of the mac reset is that the device reassociates with 
the access point. You might just have lost your link with it and for 
some reason automagic reassociation goes wrong or doesn't happen at all....
When the link is gone can you look what the BSSID is with iwconfig?
If this is the problem there isn't much the driver can do... This is all 
done by firmware. (One hack might be to have a timer do a mac_reset 
every once in a while if the link is gone)

Jeroen

