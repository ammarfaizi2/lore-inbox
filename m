Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbTGJLK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbTGJLK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:10:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59316
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269207AbTGJLKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:10:48 -0400
Subject: Re: RFC:  what's in a stable series?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: herbert@13thfloor.at
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030710033409.GA1498@www.13thfloor.at>
References: <3F0CBC08.1060201@pobox.com>
	 <20030710033409.GA1498@www.13thfloor.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1057836155.8005.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 12:22:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 04:34, Herbert Pötzl wrote:
> In my opinion (and you requested input *g*), the
> kernel userland API can be changed as much as is
> required to improve/stabilize/bugfix the kernel,
> unless this change breaks something in userland
> without an already available update/upgrade/etc ...

In a lot of cases (like O_DIRECT) its cleaner to simply break the API
in a way that will spew warnings if people miss changes than mess around
with extra methods that instead break drivers that forgot to use C99
initializers.

I plan to carry on breaking the kernel internal API when I have to
and its easy to fix up the few affected users. I broke all the audio
drivers between 2.4.21->22 but that was worth doing for example.


