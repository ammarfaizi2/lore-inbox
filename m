Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVD2OmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVD2OmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVD2OmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:42:10 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:56531 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262753AbVD2Olp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:41:45 -0400
Date: Fri, 29 Apr 2005 16:41:04 +0200
To: Andi Kleen <ak@suse.de>
Cc: Alexander Nyberg <alexn@telia.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429144103.GK18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain> <20050429143215.GE21080@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050429143215.GE21080@wotan.suse.de>
User-Agent: Mutt/1.5.9i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1DRWfw-0002F1-00*htmOJOZNeEw* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:32:15PM +0200, Andi Kleen wrote:
> 
> Hmm? saved_command_Line should have enough space to add a simple string.
> It is a 1024bytes. Unless you already have a 1k command line it should
> be quite ok.

Here it seems that it is 256 bytes :

init/main.c:char saved_command_line[COMMAND_LINE_SIZE];

include/asm-x86_64/setup.h:#define COMMAND_LINE_SIZE    256

 
> Why do you think it is bogus?
> 
> > This is bogus appending stuff to the saved_command_line and at the same
> > time in Rubens case it touches the late_time_init() which breakes havoc.
> 
> I dont agree with this patch.
> 

The patch workes here fine. After apply the Server boots without any
problem.


                        Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
