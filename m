Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRD0ID6>; Fri, 27 Apr 2001 04:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135944AbRD0IDt>; Fri, 27 Apr 2001 04:03:49 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:54220 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135922AbRD0IDk>; Fri, 27 Apr 2001 04:03:40 -0400
From: Christoph Rohland <cr@sap.com>
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <3AE879AE.387D3B78@antefacto.com>
Organisation: SAP LinuxLab
Date: 27 Apr 2001 09:58:47 +0200
In-Reply-To: <3AE879AE.387D3B78@antefacto.com>
Message-ID: <m31yqeojt4.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Padraig,

On Thu, 26 Apr 2001, Padraig Brady wrote:
> 2. Is tmpfs is basically swap and /tmp together in a ramdisk?
>    The advantage being you need to reserve less RAM for both
>    together than seperately?

tmpfs is ramfs+swap+limits. It is not using ramdisks and is not
related to them.

> 3. If I've no backing store (harddisk?) is there any advantage 
>    of using tmpfs instead of ramfs? Also does tmpfs need a 
>    backing store?

Probably yes, since you spare a little bit kernel memory. most of
tmpfs is unconditionally in the kernel for shared mappings. So the
actual CONFIG_TMPFS only adds some small functions to the kernel to
export this to usre space.

Greetings
		Christoph


