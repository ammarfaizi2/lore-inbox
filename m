Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317032AbSFKNB3>; Tue, 11 Jun 2002 09:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSFKNB2>; Tue, 11 Jun 2002 09:01:28 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:59663 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317032AbSFKNB1>; Tue, 11 Jun 2002 09:01:27 -0400
Date: Tue, 11 Jun 2002 14:01:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020611140122.B3665@flint.arm.linux.org.uk>
In-Reply-To: <20020611122144.A3665@flint.arm.linux.org.uk> <Pine.LNX.4.44.0206110611590.24261-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 06:16:10AM -0600, Thunder from the hill wrote:
> Well the question is then how will things look without commas? I suppose 
> if we have very complex things and prevent using commas whereas I don't 
> assert that we do for text but this is just a bloat example it's good to 
> have things like commas allowed even though we are in case we won't allow 
> them there talking about file names.
> 
> If we allow commas all over the filesystem and likewise say that there is 
> nothing to mention about it why should we refuse them for kbuild 
> especially since there is a parallel system which allows commas?

You've *completely* missed the point.

The gcc argument >>> -Wp,-MD,foo,bar.c <<< is the problem.  If anything
should be fixed, its that silly gcc syntax.  kbuild should not work
around the inability of gcc to accept filenames with commas in.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

