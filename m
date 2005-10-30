Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVJ3KXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVJ3KXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 05:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVJ3KXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 05:23:08 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:12752 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S1751223AbVJ3KXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 05:23:07 -0500
Message-ID: <43649ECD.3020700@tremplin-utc.net>
Date: Sun, 30 Oct 2005 19:22:05 +0900
From: Eric Piel <eric.piel@tremplin-utc.net>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Russell King <rmk@arm.linux.org.uk>,
       Michal Srajer <michal@mat.uni.torun.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/etherdevice.h, kernel 2.6.14
References: <20051029141046.GA17715@ultra60.mat.uni.torun.pl> <20051029141757.GA14039@flint.arm.linux.org.uk> <20051029154027.GC17715@ultra60.mat.uni.torun.pl> <20051029160019.GB14039@flint.arm.linux.org.uk> <95B34D3D-B658-4933-81CF-4DA25BD0F37F@able.es>
In-Reply-To: <95B34D3D-B658-4933-81CF-4DA25BD0F37F@able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> 
> Just for curiosity, could you both benchmark this also:
> 
> int is_zero_ether_addr0(const unsigned char *addr)
> {
>     return !(((unsigned long *)addr)[0] | ((unsigned short*)addr)[2]);
> }
> 

This is probably safer (wrt 64 bits systems):

int is_zero_ether_addr0(const unsigned char *addr)
{
     return !(((u32*)addr)[0] | ((u16*)addr)[2]);
}

Eric
