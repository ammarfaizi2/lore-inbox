Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTDERnU (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTDERnU (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:43:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35981
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262587AbTDERnS (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 12:43:18 -0500
Subject: Re: Linux 2.4.21-pre7: compilation error in ac97_codec.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Mathias Kretschmer <mathias@lemur.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E8E22A8.3040905@oracle.com>
References: <3E8E1243.70208@lemur.sytes.net>  <3E8E22A8.3040905@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049561776.25759.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Apr 2003 17:56:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-05 at 01:26, Alessandro Suardi wrote:
> Same for i810_audio:
> 
> gcc -D__KERNEL__ -I/share/src/linux-2.4.21-pre7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_audio  -c -o i810_audio.o i810_audio.c
> i810_audio.c: In function `i810_ac97_init':
> i810_audio.c:2930: structure has no member named `modem'
> i810_audio.c: In function `i810_probe':
> i810_audio.c:3261: warning: label `out_chan' defined but not used

Use the -ac tree ac97 code. Marcelo merged some but not all of it. The
structures changed with the logic fixes

