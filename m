Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVHBS7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVHBS7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVHBS7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:59:37 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:37910 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261685AbVHBS7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:59:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AVlWgPrKOkKZZ7UtUDdwM0hlRZQDZi6M4QmGe+/gV3eHGDuU4A4WIbTPC4n3yLWDt+c2WQq6lwJ4L4TCawuyO7RVXGMNIpPJ5YZQizTvSBR5C9x53VruZESBLKklH4eBBMfgPf8E8sZlxjhpXjMA5g78WN0LTkdlPjWwA0iID+A=
Message-ID: <5a4c581d05080211595cc07fa3@mail.gmail.com>
Date: Tue, 2 Aug 2005 20:59:08 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: 2.6.13-rc5 - ACPI regression
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050802175336.GA2959@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802175336.GA2959@mail.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> Hello,
> 
> newly with 2.6.13-rc5 (previous -rc1 was quite ok)
> 
> $ time cat /proc/acpi/battery/BAT0/info
> present:                 yes
> design capacity:         6000 mAh
> last full capacity:      6000 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 600 mAh
> design capacity low:     300 mAh
> capacity granularity 1:  60 mAh
> capacity granularity 2:  60 mAh
> model number:            M6A
> serial number:
> battery type:            LIon
> OEM info:                ASUSTEK
> 
> real    0m32.521s
> user    0m0.001s
> sys     0m0.015s

Different data point, in case this might be useful... 

Dell Latitude C640, uptodate FC4, kernel built with stock GCC 4.0.1:

time cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         65120 mWh
last full capacity:      45300 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            LIP8120DLP
serial number:           363
battery type:            LION
OEM info:                Sony Corp.

real    0m1.372s
user    0m0.000s
sys     0m1.340s

--alessandro

 "Nothing's hard as getting free from places I've already been"

    (Wallflowers - "I've Been Delivered")
