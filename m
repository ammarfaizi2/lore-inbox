Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274822AbTGaRgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274827AbTGaRgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:36:05 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:12049 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S274822AbTGaRgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:36:01 -0400
Date: Thu, 31 Jul 2003 19:35:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Zack Brown <zbrown@tumblerings.org>
Cc: "Ata, John" <John.Ata@digitalnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: incompatible open modes
Message-ID: <20030731173558.GA2939@win.tue.nl>
References: <6DED202D454D3B4EB7D98A7439218D610C9AB7@vahqex2.gfgsi.com> <20030731170345.GJ6693@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731170345.GJ6693@renegade>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jul 31, 2003 at 12:09:14PM -0400, Ata, John wrote:

> >    the manpage on "open" states that if a file is opened "O_RDONLY|O_TRUNC",
> >    the O_TRUNC is either ignored or an error is returned.  The 2.4 kernel
> >    appears to cheerfully truncate the file on open.  I wondered which
> >    behavior is actually intended.
> >
> >    O_TRUNC
> >        If the file already exists and is a regular file  and  the open
> >        mode  allows  writing  (i.e.,  is O_RDWR or O_WRONLY) it will be
> >        truncated to length 0.  
> >        Otherwise the effect of O_TRUNC is unspecified.
> >        (On many Linux versions it will be ignored; on other versions
> >        it will return an error.)

This was just recently discussed, and it became clear that the parenthetical
remark only led to confusion. It has been deleted. Instead

       The (undefined) effect of O_RDONLY | O_TRUNC various among
       implementations.  On  many  systems  the  file is actually
       truncated.

has been added.

Andries

