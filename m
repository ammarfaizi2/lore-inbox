Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWINTDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWINTDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWINTDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:03:33 -0400
Received: from mailhost.terra.es ([213.4.149.12]:37199 "EHLO
	csmtpout4.frontal.correo") by vger.kernel.org with ESMTP
	id S1751031AbWINTDc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:03:32 -0400
Date: Thu, 14 Sep 2006 21:03:12 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: mingo@elte.hu, mathieu.desnoyers@polymtl.ca, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, mingo@redhat.com, gregkh@suse.de,
       tglx@linutronix.de, zanussi@us.ibm.com, ltt-dev@shafik.org,
       michel.dagenais@polymtl.ca
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-Id: <20060914210307.2cd10da4.grundig@teleline.es>
In-Reply-To: <450971CB.6030601@mbligh.org>
References: <20060914033826.GA2194@Krystal>
	<20060914112718.GA7065@elte.hu>
	<450971CB.6030601@mbligh.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 14 Sep 2006 08:14:19 -0700,
"Martin J. Bligh" <mbligh@mbligh.org> escribió:

> 2. You can get zero overhead by CONFIG'ing things out.

IOW, no distro will enable it by default to avoid the overhead,
making it useless for lots of real-world working systems where
you need to guess what's hapenning to software running real
workloads that can't just be stopped.

I guess there's no problem in having both LTT and Kprobes merged in 
the main tree at the same time. But Kprobes + systemtap will get
enabled and used by distros massively just because users can start
using it inmediately, without recompiling or installing extra
kernels and rebooting. There're cases where distros may want to
enable automatic tracing in every boot and only on boot but that
don't like to suffer from an extra performance hit after booting...

I'm not meaning that LTT sucks and doesn't have advantages and that 
doesn't deserve being merged/used, it just looks like kprobes+systemtap
will get way more real-world users no matter how much you discuss here
