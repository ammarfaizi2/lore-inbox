Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWI2KIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWI2KIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWI2KIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:08:05 -0400
Received: from mx1.x-echo.com ([193.252.148.73]:45773 "EHLO smtp1.x-echo.com")
	by vger.kernel.org with ESMTP id S932155AbWI2KIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:08:02 -0400
Message-ID: <451CF08D.8030606@lea-linux.com>
Date: Fri, 29 Sep 2006 12:08:13 +0200
From: Tchesmeli Serge <serge@lea-linux.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ? Strange behaviour since kernel 2.6.17 with a https website
References: <451CEBA8.8050604@lea-linux.com> <20060929100211.GB19115@zlug.org>
In-Reply-To: <20060929100211.GB19115@zlug.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel wrote:
> On Fri, Sep 29, 2006 at 11:47:20AM +0200, Tchesmeli Serge wrote:
>
>   
>> Me and a friend have discover a stange behaviour since kernel 2.6.17.
>>     
>
> Please try to switch off TCP window scaling using the command below
> (as root) and retry.
>
> echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
>
>   
Yes, it's work!
Test:
-------


darkstar@stchesmeli:~$ sudo su -
Password:

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
root@stchesmeli:~# logout

darkstar@stchesmeli:~$ wget --no-check-certificate
"https://e.secure.lcl.fr/v_1.0
--12:05:57--  https://e.secure.lcl.fr/v_1.0/css/styleAp.css
           => `styleAp.css.10'
Resolving e.secure.lcl.fr... 193.110.152.59
Connecting to e.secure.lcl.fr|193.110.152.59|:443... connected.
WARNING: Certificate verification error for e.secure.lcl.fr: unable to
get local issuer certificate
HTTP request sent, awaiting response... 200 OK
Length: 42,745 (42K) [text/css]

100%[=================================================================================================================>]
42,745        --.--K/s            

12:06:00 (424.53 KB/s) - `styleAp.css.10' saved [42745/42745]

------------ END OF TEST ----------------

Many thanks!!

-- 
Tchesmeli serge
Administrateur système & réseau
Expert Linux et Logiciels Libres

