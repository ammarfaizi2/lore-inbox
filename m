Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269152AbTCBANl>; Sat, 1 Mar 2003 19:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbTCBANl>; Sat, 1 Mar 2003 19:13:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41879
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269152AbTCBANk>; Sat, 1 Mar 2003 19:13:40 -0500
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
	at mm/slab.c:1617'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030301210518.GA740@gallifrey>
References: <20030301210518.GA740@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046568414.24557.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 02 Mar 2003 01:26:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 21:05, Dr. David Alan Gilbert wrote:
> Hi,
>   2.5.63 had a good go at trying to boot for me; the only error during
> boot was 'Debug: sleeping function called from illegal context at
> mm/slab.c:1617' during the IDE startup.

Known problem. Its a bug in the request_irq code on x86. IDE just
happens to be a victim of it.

