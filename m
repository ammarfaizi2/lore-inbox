Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWGKT0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWGKT0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGKT0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:26:04 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:55249 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750857AbWGKT0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:26:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CeAx/nBGLGPWsa6iursjqN1KQSUVcfp6loxsQIcQvI1vNSQVerDevJaQafIGIJhhHov6Aw/bWS+KF0OtGxyJoAN8cygcTPQEM/tqhnundJJ06op7+6QNiXerLWQWYrXQ/cT3p0apYaJFDts89wZ6PdIy+gb6YRUrxkrKm8CMCyE=
Message-ID: <1defaf580607111226r2f0eac2n51fb513c3e88b1cc@mail.gmail.com>
Date: Tue, 11 Jul 2006 21:26:02 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/7] AVR32: Fix invalid constraints for stcond
Cc: "Haavard Skinnemoen" <hskinnemoen@atmel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44B3E8CD.8070409@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <11526218021728-git-send-email-hskinnemoen@atmel.com>
	 <11526218022840-git-send-email-hskinnemoen@atmel.com>
	 <11526218024091-git-send-email-hskinnemoen@atmel.com>
	 <44B3E8CD.8070409@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Haavard Skinnemoen wrote:
> > Because gcc doesn't seem to like arch-dependent constraints in inline
> > asm, we ended up using "m" as constraint for the stcond instruction.
>
> Bunkum.  That would be a bug in the AVR32 gcc, but gcc handles
> arch-specific constraints in inline assembly all the time.  The kernel
> wouldn't compile for a large number of architectures otherwise.

Thanks, then we at least know it's a gcc bug. It's sometimes hard to
tell what features are actually supposed to work, especially the stuff
that's only documented in the internals manual...

Anyway, "o" is apparently more correct than "m" since with "o" it
manages to compile all the filesystems without complaining, and the
output looks correct. On the other hand, ocfs2 probably isn't
something you want to use on your AVR32 board...

Håvard
