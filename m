Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUDASDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUDASDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:03:13 -0500
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:42937 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S263010AbUDASDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:03:06 -0500
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Thu, 1 Apr 2004 20:03:02 +0200
User-Agent: KMail/1.6.1
References: <200404011900.47412.volker.hemmann@heim10.tu-clausthal.de> <20040401171012.GB24255@redhat.com>
In-Reply-To: <20040401171012.GB24255@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404012003.02246.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 01 April 2004 19:10, Dave Jones wrote:
> On Thu, Apr 01, 2004 at 07:00:47PM +0200, Hemmann, Volker Armin wrote:
>  > Hi,
>  >
>  > in 2.6.5-rc3 was incorporated a fix for SiS648 chipsets that need a
>  > little time to get into a sane state again, after switching to AGP 8x.
>  > The 746FX has the same timing problem and needs this 'pause', too.
>  > Unfortunatly in sis-apg.c this fix is only checked against the 648, not
>  > the 746, so the fix never gets invoked:
>
> Ah, yes. I actually had that in mind when I merged this code, but it
> must've got paged out 8-)
>
> Can you send lspci -n output please?
>
> 		Dave

here it is:
energy root # lspci -n
0000:00:00.0 Class 0600: 1039:0746 (rev 02)
0000:00:01.0 Class 0604: 1039:0002
0000:00:02.0 Class 0601: 1039:0963 (rev 25)
0000:00:02.1 Class 0c05: 1039:0016
0000:00:02.5 Class 0101: 1039:5513
0000:00:03.0 Class 0c03: 1039:7001 (rev 0f)
0000:00:03.1 Class 0c03: 1039:7001 (rev 0f)
0000:00:03.2 Class 0c03: 1039:7002
0000:00:04.0 Class 0200: 1039:0900 (rev 90)
0000:00:0b.0 Class 0400: 109e:0350 (rev 12)
0000:00:0d.0 Class 0401: 13f6:0111 (rev 10)
0000:01:00.0 Class 0300: 10de:0322 (rev a1)


Glück Auf,
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
