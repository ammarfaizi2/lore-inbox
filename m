Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291166AbSBLSeO>; Tue, 12 Feb 2002 13:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291164AbSBLSeC>; Tue, 12 Feb 2002 13:34:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16391 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291152AbSBLSdr>; Tue, 12 Feb 2002 13:33:47 -0500
Date: Tue, 12 Feb 2002 13:32:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Padraig Brady <padraig@antefacto.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <3C695035.6040902@antefacto.com>
Message-ID: <Pine.LNX.3.96.1020212132711.6082B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Padraig Brady wrote:

> I'd go for tacking it on at the end of the bzImage. Advantages would be
> that it can be read even when the kernel isn't loaded, and also there
> is no danger of loading a module in another kernel.

There are several problems with that:
1 - built into the kernel it is compressed and needs a tool to read
2 - the reason kernels are compressed is to make them fit in small boot
    media, so adding something to the image is not to be done lightly.
3 - modules are NOT compressed, and can be read with the strings command.
4 - other files in the modules directory are pure text and if the config
    was just text it could be read with `cat.'

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

