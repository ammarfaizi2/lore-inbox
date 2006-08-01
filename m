Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWHASLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWHASLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHASLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:11:31 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:53645 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750956AbWHASLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:11:31 -0400
Date: Tue, 1 Aug 2006 20:11:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mika Penttil? <mika.penttila@kolumbus.fi>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/33] i386: Relocatable kernel support.
Message-ID: <20060801181120.GA8747@mars.ravnborg.org>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <11544302351934-git-send-email-ebiederm@xmission.com> <44CF5850.80906@kolumbus.fi> <m1y7u8xrcp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y7u8xrcp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 12:07:02PM -0600, Eric W. Biederman wrote:
> Mika Penttil? <mika.penttila@kolumbus.fi> writes:
> 
> >> @@ -1,9 +1,10 @@
> >>  SECTIONS
> >>  {
> >> -  .data : { +  .data.compressed : {
> >>  	input_len = .;
> >>  	LONG(input_data_end - input_data) input_data = .;  	*(.data)
> >> +	output_len = . - 4;
> >>  	input_data_end = .;  	}
> >>  }
> >>
> > I don't see how you are getting the uncompressed length from output_len...
> 
> It's part of the gzip format.  It places the length at the end of
> the compressed data.  I am just computing the address of where gzip
> put the length and putting a variable there called output_len.
> 
> Isn't linker script magic wonderful :)
A comment would be appreciated.

	Sam
