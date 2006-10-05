Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWJEL6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWJEL6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWJEL6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:58:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:28127 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751106AbWJEL6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:58:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hs1Ym3bfiJl65DPh1qbCE46vlEfJO8/eU/WXnAiZNCKWYi1xRT/WvmTFguwlxGkc7T5xY/oGJI6+p0TI1xRW0tmGHeySiohVcTzWeAoGJoh7Fff/mlQ8n6JiBUBfUqijkmiZjlyT94kWYzL6+11Ql+WMHuNAF66BWOD+HzTcPcY=
Message-ID: <aec7e5c30610050458x1fbe52bex851779d73c004350@mail.gmail.com>
Date: Thu, 5 Oct 2006 20:58:22 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Lukas Hejtmanek" <xhejtman@mail.muni.cz>
Subject: Re: Machine reboot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061005105250.GI2923@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061005105250.GI2923@mail.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/06, Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> Hello,
>
> I'm facing troubles with machine restart. While sysrq-b restarts machine, reboot
> command does not. Using printk I found that kernel does not hang and issues
> reset properly but BIOS does not initiate boot sequence. Is there something
> I could do?

A long shot, but switching to real mode does not work if the cpu is
running in VMX root mode ie on hardware with Intel VT extensions
enabled. So if you are using some kind of kernel virtualization module
on rather new hardware, consider rmmod:ing the module before
rebooting.

I'm about to post patches for kexec that fixes this problem, but I'm
not sure about the current reboot status.

/ magnus
