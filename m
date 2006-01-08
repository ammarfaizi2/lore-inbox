Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWAHG6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWAHG6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWAHG6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 01:58:12 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:63909 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751175AbWAHG6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 01:58:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RTpJ2lmzq+hCq8SLA57Bo3O18NEFzwJaXIRlN43/AdYOEgpshu1/wL0qr8ddZ8Xm8kYtzbz+gKTvqvHbX0vPYzkVpgJ/vMMNEekUK6XjltEbGNobi8h3PjgN+VVHGPQHONpKatwHKkvwauzJ2yy851+0QJztWv6FLjlWOxfowWQ=
Message-ID: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com>
Date: Sun, 8 Jan 2006 07:58:09 +0100
From: Markus Rechberger <mrechberger@gmail.com>
To: gcoady@gmail.com
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what does hdparm show up?
Were there any other processes running during the test?
what does "vmstat 1" show up during the test?

Markus

On 1/8/06, Grant Coady <gcoady@gmail.com> wrote:
> Hi there,
>
> Recently I started testing 2.6 stable on my firewall box here, I
> work via ssh terminals to firewall and have a good feel for the
> CLI responsiveness.
>
> The test?  Just a simple display the apache access log, but it is
> very slow with 2.6 kernels (2.6.14.5, 2.6.14.6, 2.6.15):
>
> 2.4.32-hf32.1:
> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96
> [...]
> 2006-01-08 14:38:52 +1100: bugsplatter.mine.nu 207.46.98.39 "GET /test/linux-2.6/sempro/ HTTP/1.
>
> real    0m1.562s
> user    0m0.600s
> sys     0m0.310s
>
> 2.6.14.6:
> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96
> [...]
> 2006-01-08 14:38:52 +1100: bugsplatter.mine.nu 207.46.98.39 "GET /test/linux-2.6/sempro/ HTTP/1.
>
> real    0m6.318s
> user    0m0.690s
> sys     0m1.140s
>
> grant@deltree:~$ /sbin/lspci
> 00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
> 00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
> 00:07.1 IDE interface: Intel Corporation 82371FB PIIX IDE [Triton I] (rev 02)
> 00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0e.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:10.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 44)
>
> dmesg + .config on: http://bugsplatter.mine.nu/test/boxen/deltree/
>
> --
> Thanks,
> Grant.
> http://bugsplatter.mine.nu/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Markus Rechberger
