Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTDERTC (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbTDERTC (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:19:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24717
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262543AbTDERTC (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 12:19:02 -0500
Subject: Re: [PATCH][2.4.21-pre7] fix genksyms core dump in
	drivers/char/joystick
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, adam@os.inf.tu-dresden.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304051359.h35DxBLD015292@harpo.it.uu.se>
References: <200304051359.h35DxBLD015292@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049560312.25700.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Apr 2003 17:31:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-05 at 14:59, mikpe@csd.uu.se wrote:
> This patch fixes this problem by using inline functions for the
> stubs instead of #defines.

You've changed the semantics completely

> -#define pcigame_attach(a,b)	NULL
> -#define pcigame_detach(a)
> +static inline struct pcigame *pcigame_attach(struct pci_dev *dev, int type)
> +{
> +	return NULL;
> +}


