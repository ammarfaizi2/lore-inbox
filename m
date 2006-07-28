Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWG1ROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWG1ROK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWG1ROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:14:10 -0400
Received: from unassigned-87.236.194.20.coolhousing.net ([87.236.194.20]:43024
	"EHLO mail.agmk.net") by vger.kernel.org with ESMTP
	id S1161181AbWG1ROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:14:08 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Date: Fri, 28 Jul 2006 19:13:37 +0200
User-Agent: KMail/1.9.3
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102627.6416.13.camel@laptopd505.fenrus.org> <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
In-Reply-To: <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281913.37889.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 18:24, Daniel Walker wrote:
> On Fri, 2006-07-28 at 18:03 +0200, Arjan van de Ven wrote:
> > ---
> >  arch/x86_64/Kconfig |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
>
> Could this be supported on more than just x86_64, it seems fairly
> generic ?

yes, it could.

gcc supports stack protection at so called tree-level (it means
it's architecture-independent). i've just tested a simple userland-code:

#include <stdlib.h>
#include <string.h>
int main()
{
	char c;
	memset( &c, 0, 512 );
	return 0;
}

and stack protection works fine on {ix86,x86-64,powerpc}-linux.
i can test it on {alpha,sparc}-linux later but i'm pretty sure
it'll work too on these archs.
