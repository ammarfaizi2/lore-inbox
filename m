Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbTB1MQx>; Fri, 28 Feb 2003 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbTB1MQx>; Fri, 28 Feb 2003 07:16:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8593
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267843AbTB1MQw>; Fri, 28 Feb 2003 07:16:52 -0500
Subject: Re: C-Media 9739 codec - solution found
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Monniaux <David.Monniaux@ens.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E5ED1DA.3090808@ens.fr>
References: <3E5ED1DA.3090808@ens.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046438992.16598.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 13:29:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 03:04, David Monniaux wrote:
> This driver works well with 2.4.20.
> 
> Who maintains the i810_audio / AC97-related things? I think the C-Media 
> driver should be folded into the regular kernel (otherwise it won't get 
> maintained).

A lot of it duplicates existing functionality we have and in a different
way. Nothing wrong with the way they have done it but it does make merging
that kind of thing hard. The Linux ac97 code has digital control ops that
very few codecs use. It should be possible to populate those from this
and this code also has a few oddments about the sis7012/18 that may help
fix some stuff [We don't have SiS docs]



