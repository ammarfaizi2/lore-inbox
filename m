Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbTEaO73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTEaO73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:59:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44512
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264413AbTEaO70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:59:26 -0400
Subject: Re: [PATCH] Eat keys on panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@digeo.com
In-Reply-To: <20030531115653.GA11119@wotan.suse.de>
References: <20030531115653.GA11119@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054390488.27311.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 May 2003 15:14:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-31 at 12:56, Andi Kleen wrote:

> +void eat_key(void)
> +{
> +        if (inb(0x60) & 1) 
> +                inb(0x64);
>  }

This will crash at least one of my machines. The keyboard controller
has mandatory access delays of up to 1mS. Respect them or some stuff
dies horribly.


