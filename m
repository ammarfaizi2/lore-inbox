Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRKHRxQ>; Thu, 8 Nov 2001 12:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276988AbRKHRxG>; Thu, 8 Nov 2001 12:53:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:49168 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S276751AbRKHRw7>;
	Thu, 8 Nov 2001 12:52:59 -0500
Subject: Re: speed difference between using hard-linked and modular drives?
From: Robert Love <rml@tech9.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111081700240.1916-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111081700240.1916-100000@mustard.heime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 08 Nov 2001 12:53:03 -0500
Message-Id: <1005241983.939.39.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-08 at 11:01, Roy Sigurd Karlsbakk wrote:
> Are there any speed difference between hard-linked device drivers and
> their modular counterparts?

On top of what Ingo said, there is also a slightly larger (very slight)
memory footprint due to some of the module code that isn't included in
in-kernel components.  For example, the __exit functions aren't needed
if the driver is not a module.

	Robert Love

