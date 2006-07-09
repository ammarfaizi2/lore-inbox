Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWGIRWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWGIRWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWGIRWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:22:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25299 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964880AbWGIRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:22:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KkMCcJJh39laXEBOZsPnfxZKEepj8NzkVFqH5zfCze4PTM6Zstmc5lkfWvKR9bNPp7lJtQ3aHbwJaxd7rkL8AVjR292VjldWwe+q7vv3/CDuG528nvgm3cma9HTU48HFUGNIgmPoiODzN0mxiCHX1wQcAIIUWFabbJysuMZIekY=
Message-ID: <787b0d920607091022l4e4e7b1en41781a50a1ab048f@mail.gmail.com>
Date: Sun, 9 Jul 2006 13:22:53 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: devices.txt errors
Cc: linux-kernel@vger.kernel.org, device@lanana.org
In-Reply-To: <20060710024315.7dacd7f9.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082349h59ec36f7nc477e3cc9f9b6c77@mail.gmail.com>
	 <20060710024315.7dacd7f9.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Sun, 9 Jul 2006 02:49:19 -0400 "Albert Cahalan" <acahalan@gmail.com> wrote:
> >
> > Some names, like "/dev/iseries/vtty%d", are too damn big.
>
> As far as I know they were never used and certainly aren't now.  We did
> once use /dev/viocons/%d, but that went away a long time ago (before the
> code was in the mainline kernel).  Major 229 is now used by the pSeries
> Hypervisor consoles (/dev/hvc%d) and hopefully soon by a new iSeries
> hypervisor console with the same name.

Since that still isn't in devices.txt...

/dev/ttyHV%d would match the standard pattern better.
(assuming you only need 3-digit numbers)
