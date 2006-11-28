Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757015AbWK1Xqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbWK1Xqd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757054AbWK1Xqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:46:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:47929 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1757015AbWK1Xqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:46:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Gg+M3iLGg2fcQCL72lNjGRYQzwAH4LTZOnl5iQMBXYaFW8aMyh6qI+XRsdzTo/JUbAvx0ThVzzoRwJQ5BJmj1Xs4yUH1boRK+mhyRh3hoEb20NtGpwUIlPF12GnJdOlSl6NXDV0wEpiJ6NgTE2BBR6j8HslKvccSpnifXi5Ddtw=
Message-ID: <456CCA54.6090504@gmail.com>
Date: Tue, 28 Nov 2006 21:46:28 -0200
From: Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 tsc clocksource + ntp = excessive drift; acpi_pm does fine.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with default boot I got tsc clocksource selected on an debian's 
2.6.18-3-k7 SMP build (but UP machine). ntp keeps bothering me with this 
message:
frequency error 512 PPM exceeds tolerance 500 PPM

If I remove ntp's drift file and restart, it goes fine for a while and 
then it goes with that behaviour again.
If I remove ntp's drift file, then do a: echo acpi_pm 
 >/sys/devices/system/clocksource/clocksource0/available_clocksource ; 
and then restart ntp, it goes fine "forever".

Any toughs, something I should look at?

I'll be glad to give more feedback.

I don't know if that happened with 2.6.17, but I'm pretty sure that with 
2.6.16 it was fine.

- Alexandre
