Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTCFAVi>; Wed, 5 Mar 2003 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTCFAVi>; Wed, 5 Mar 2003 19:21:38 -0500
Received: from usen-43x235x12x234.ap-USEN.usen.ad.jp ([43.235.12.234]:31373
	"EHLO miyazawa.org") by vger.kernel.org with ESMTP
	id <S267285AbTCFAV0>; Wed, 5 Mar 2003 19:21:26 -0500
Date: Thu, 6 Mar 2003 09:32:19 +0900
From: Kazunori Miyazawa <kazunori@miyazawa.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi-core@linux-ipv6.org
Subject: Re: [PATH] IPv6 IPsec support
Message-Id: <20030306093219.1a702868.kazunori@miyazawa.org>
In-Reply-To: <20030305.152530.70806720.davem@redhat.com>
References: <20030305233025.784feb00.kazunori@miyazawa.org>
	<20030305.152530.70806720.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Wed, 05 Mar 2003 15:25:30 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Kazunori Miyazawa <kazunori@miyazawa.org>
>    Date: Wed, 5 Mar 2003 23:30:25 +0900
> 
> Hello Miyazawa-san,
> 
>    I submit the patch to let the kernel support ipv6 ipsec again.
>    It is able to comple ipv6 as module.
> 
> As promised I applied the patch.  I will push it to Linus later
> this evening, or tomorrow.
> 
> In this initial checkin I made only 2 minor fixes, they
> are attached below:
> 

Thank you very much.

My patch is the first step.
 I think there are these TODOs around IPv6 IPsec as far as I remember.

- Extension Header Processing on inbound:
  As a result of IPv6 IPsec support, Extension Header processing is devided
  into ipv6_parse_exthdrs and ipproto->handler. I think it is better to merge
  other Extension Header handling into ipproto->handler.

- Fragmentation support on outbound:
  We should change ipv6_build_xmit like ip_append_data style to support
  fragmentation with IPsec.

- Removing duplicate codes, clean up and improveing performance.

- Considering relation of IPv6 IPsec and Mobile IPv6. This is future stuff.

Best regards,

--Kazunori Miyazawa (Yokogawa Electric Corporation)

