Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWGJDKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWGJDKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWGJDKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:10:25 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:46543 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161312AbWGJDKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:10:25 -0400
Date: Mon, 10 Jul 2006 05:10:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org
Subject: Re: ./scripts/kallsyms.c question
Message-ID: <20060710031008.GA5381@mars.ravnborg.org>
References: <6.1.1.1.0.20060709193540.01ec8370@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.0.20060709193540.01ec8370@ptg1.spd.analog.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 10:26:39PM -0400, Robin Getz wrote:
> The application kallsyms generate assembler source containing symbol 
> information, where "symbol information" is in these pre-defined names:
> 
>  _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext
> 
> I am working with a processor (Blackfin) which uses these plus two others 
> _stext_l1, and _etext_l1.
> 
> I can add these in the same fashion as the existing (see below), but was 
> wondering if this shouldn't be re-structured with a struct/loop rather than 
> the existing n lines of if/else?
Keep the existing if/else - it is still readable.
But please add a comment describing that it is blackfin that requires
these two odd sections.

	Sam
