Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTEMTOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTEMTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:14:38 -0400
Received: from terminus.zytor.com ([63.209.29.3]:61828 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263468AbTEMTOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:14:37 -0400
Message-ID: <3EC14706.1010200@zytor.com>
Date: Tue, 13 May 2003 12:27:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <200305130851_MC3-1-38A3-A3B4@compuserve.com> <b9refc$qmd$1@cesium.transmeta.com> <Pine.LNX.4.53.0305131501150.2332@chaos>
In-Reply-To: <Pine.LNX.4.53.0305131501150.2332@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> Don't thing there's anything much easier than:
> 
> 		movl	$1, %eax
> 		movl	%eax, %cr0
> 
> ... execute that in paged RAM (above the 1:1 mapping), and you
> will get a hard processor reset without any bus access at all.
> This unmaps everything in one fell-swoop.
> 

You go back to 1:1 mappings at that point, so you *will* have bus accesses.

	-hpa

