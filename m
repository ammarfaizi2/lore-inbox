Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbUDSAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUDSAbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:31:09 -0400
Received: from mail.shareable.org ([81.29.64.88]:50851 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264219AbUDSAbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:31:07 -0400
Date: Mon, 19 Apr 2004 01:30:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric <eric@cisu.net>
Cc: stl@nuwen.net, linux-kernel@vger.kernel.org
Subject: Re: Process Creation Speed
Message-ID: <20040419003026.GC11064@mail.shareable.org>
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404180044.02850.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404180044.02850.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> > It matters to me because the Common Gateway Interface spawns and destroys a
> > process to handle each request, and I wish it were just fast, rather than
> > having to use FastCGI.
>
> 	The difference in speed between regular and FastCGI shouldnt
> be related to process creation time. The speed up you see from
> FastCGI is because it doesn't have to be read from disk each
> time. So, you're really looking for performace enhancements in the
> wrong place. Tweaking process creation can't make your platters spin
> faster.

Wrong explanation.  CGI does not "read from disk each time".  Files,
including executables, are cached in RAM.  Platter speed is irrelevant
unless your server is overloaded, which this one plainly isn't.

-- Jamie
