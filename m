Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVBDISk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVBDISk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 03:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBDISj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 03:18:39 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:16107 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263531AbVBDIRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 03:17:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LHplP7VyPSjGAzjJcXRByWzRtMjkEalY/0J/AQ/i6dicj3Fy8rdWRyxgC3D0Xyy034OPIXSZpbMS9cwd0+mE3olvktNXw0NGlnnXePMFaJ35qgufI11TxG1WrZs8D/9sr1Femw8/EhKsb0poQZ/6Aa/Xjx1oFioRhZeUQn2DkvU=
Message-ID: <84144f0205020400172d89eddf@mail.gmail.com>
Date: Fri, 4 Feb 2005 10:17:48 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Olof Johansson <olof@austin.ibm.com>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       trini@kernel.crashing.org, benh@kernel.crashing.org, hpa@zytor.com,
       akpm@osdl.org, penberg@cs.helsinki.fi
In-Reply-To: <20050204072254.GA17565@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050204072254.GA17565@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Feb 2005 01:22:54 -0600, Olof Johansson <olof@austin.ibm.com> wrote:
> +#define CPU_HAS_FEATURE(x)     (cur_cpu_spec->cpu_features & CPU_FTR_##x)
> +

Please drop the CPU_FTR_##x macro magic as it makes grepping more
complicated. If the enum names are too long, just do s/CPU_FTR_/CPU_/g
or something similar. Also, could you please make this a static inline
function?

                                  Pekka
