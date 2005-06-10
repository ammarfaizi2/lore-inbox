Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVFJJHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVFJJHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVFJJHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:07:50 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:16925 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262528AbVFJJHc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:07:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uuNeNDCNVoIF3cqFDcmwtR3WrVE9PAXVhlWJmrj0X0TFsty1d7cLA6wSx6QVzh6/n9LviSKx8FzPd2UzHByQmRGQG9wRhu5rd+EYIwtEmhIJTcnYbSHpnNsoDln1qq1ggrAEMVX5iONa3gGpkurdl8K3CKw35HZvFxUqqA9JSvg=
Message-ID: <4ad99e050506100207224a263f@mail.gmail.com>
Date: Fri, 10 Jun 2005 11:07:31 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: Fusion MPT driver version 3.01.20 VS. version 2.03.00
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050609145709.GA23865@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e050506071428278c3018@mail.gmail.com>
	 <20050607224033.GA14108@localhost.localdomain>
	 <4ad99e05050609012630a2ad3@mail.gmail.com>
	 <20050609145709.GA23865@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/05, Sonny Rao <sonnyrao@us.ibm.com> wrote:

> Yeah, the only other thing I noticed is that your IRQ number is really
> large compared to mine, I'm not sure if that's some artifact of ACPI
> or what is going on there.  Have you tried turning off ACPI or
> pci=routeirq and the like?

Nope but I will look at it.

> 
> My /proc/interrupts looks like this:
> 
>            CPU0       CPU1       CPU2       CPU3
>   0:   80270452          0          0          0    IO-APIC-edge
> timer
>   1:      31529          0          0          0    IO-APIC-edge i8042
>   5:          0          0          0          0   IO-APIC-level  acpi
>   8:          1          0          0          0    IO-APIC-edge  rtc
>  11:          0          0          0          0   IO-APIC-level ohci_hcd
>  12:     503960          0          0          0    IO-APIC-edge i8042
>  15:     721836          0          0          0    IO-APIC-edge  ide1
>  22:     152445          0          0          0   IO-APIC-level  ioc0
>  25:     922998          0          0          0   IO-APIC-level  eth1
> NMI:          0          0          0          0
> LOC:   80274015   80273964   80274024   80274023
> ERR:          0
> MIS:          0
> 
> Is yours similar?

My looks like this on kernel 2.6:

---------------------
           CPU0       CPU1       CPU2       CPU3
  0:      13089          0  251098584          0    IO-APIC-edge  timer
  1:          8          0          0          0    IO-APIC-edge  i8042
  5:          0          0          0          0   IO-APIC-level  acpi
  8:         73          0          0          0    IO-APIC-edge  rtc
 11:          0          0          0          0   IO-APIC-level  ohci_hcd:usb1
 12:        110          0          0          0    IO-APIC-edge  i8042
 15:         12          0          0          0    IO-APIC-edge  ide1
169:   24892566          0          0          0   IO-APIC-level  ioc0
177:  121556391          0          0          0   IO-APIC-level  eth0
NMI:          0          0          0          0
LOC:  251145010  251145083  251145081  251145081
ERR:          0
MIS:          0
---------------------

using kernel 2.4 it looks like this

---------------------
          CPU0       CPU1       CPU2       CPU3
  0:  128904101          0          0          0    IO-APIC-edge  timer
  1:          2          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  8:        358          0          0          0    IO-APIC-edge  rtc
 11:          0          0          0          0   IO-APIC-level  usb-ohci
 15:          2          0          0          0    IO-APIC-edge  ide1
 22:   68048860          0          0          0   IO-APIC-level  ioc0
 24:  610278021          0          0          0   IO-APIC-level  eth0
NMI:          0          0          0          0
LOC:  128905644  128905629  128905632  128905638
ERR:          0
MIS:          0
---------------------


I  think you have good points about the irq beeing high.



Regards.

Lars Roland
