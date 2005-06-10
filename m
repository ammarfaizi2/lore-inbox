Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVFJN40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVFJN40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVFJN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:56:25 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:22915 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S262529AbVFJNzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:55:46 -0400
Message-ID: <42A99BCD.8000901@a-wing.co.uk>
Date: Fri, 10 Jun 2005 14:55:25 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Subject: Re: sis190
References: <42A621BC.7040607@a-wing.co.uk> <20050607225755.GB30023@electric-eye.fr.zoreil.com> <42A62BD0.7090709@a-wing.co.uk> <20050608225157.GA16107@electric-eye.fr.zoreil.com> <42A82FE3.3080603@a-wing.co.uk> <20050609211843.GA5630@electric-eye.fr.zoreil.com>
In-Reply-To: <20050609211843.GA5630@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Andrew Hutchings <info@a-wing.co.uk> :
> [...]
> 
>>Tried it, it didn't detect the sis190 in this board so I changed the 
>>PCI_ID lines to:
>>static struct pci_device_id sis190_pci_tbl[] __devinitdata = {
>>   { 0x1039, 0x0190, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>>   { 0,},
>>};
> 
> 
> /me scratches head
> 
> The figures look the same. I must be tired.
> 

I thought so, but for some reason it makes a difference.

> 
>>This then detected it but caused a soft lockup on modprobe with a dump 
>>which I have attached here.  I have also attched lspci -vvv and -xxx for 
>>you.
> 
> 
> Right, there was a bug. I am not sure the fix will really fix though.
> 
> See the patch of the day:
> 
> http://www.fr.zoreil.com/people/francois/misc/20050610-2.6.12-rc-sis190-test.patch
> 
> Please add a dmesg as well if something goes wrong.
> 

Something went wrong on build.  Getting 'syntax error before '}' token' 
on every line there is _msleep(1);

Regards
Andrew
-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 311: transient bus protocol violation
