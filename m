Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSHJKg1>; Sat, 10 Aug 2002 06:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSHJKg1>; Sat, 10 Aug 2002 06:36:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:46605 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316786AbSHJKg1>; Sat, 10 Aug 2002 06:36:27 -0400
Date: Sat, 10 Aug 2002 11:40:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
Message-ID: <20020810114003.A5459@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com> <20020809222736.GJ32427@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020809222736.GJ32427@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Sat, Aug 10, 2002 at 01:27:36AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 01:27:36AM +0300, Matti Aarnio wrote:
>   How NetBSD handles the issue, I don't know.   One interpretation
>   of what you say is that when a new architecture is added to NetBSD,
>   it will instantly inherit the entire historical set of syscalls,
>   including the obsolete ones.

netbsd puts all syscall code not needed by the current release under a
per-version ifdef.  A new port starting at, say 1.4, will never have
this enabled (unless it has binary emulations that need parts of the
old syscalls)

