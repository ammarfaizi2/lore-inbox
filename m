Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWEBHBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWEBHBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEBHBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:01:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22214 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932420AbWEBHBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:01:20 -0400
Subject: Re: Open Discussion, kernel in production environment
From: Arjan van de Ven <arjan@infradead.org>
To: Marcin Hlybin <marcin.hlybin@swmind.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605012357.48623.marcin.hlybin@swmind.com>
References: <200605012357.48623.marcin.hlybin@swmind.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 09:01:14 +0200
Message-Id: <1146553275.32045.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 23:57 +0200, Marcin Hlybin wrote:
> Hello,
> 
> I always configure and compile a kernel throwing out all unusable options and 
> I never use modules in production environment (especially for the router). 
> But my superior has got the other opinion - he claims that distribution 
> kernel is quite good and in these days optimization has no sense because of 
> powerful hadrware. 


he's basically right; the gain you get by disabling the generic things a
distribution enabled is way down in the noise. There are some
compromises a distribution makes to keep the number of kernels they ship
down, and I suspect the worst possible case would add up to say 5%.

(on a Fedora / RHEL that would probably be a SMP system with less than
1Gb of ram)

On the plus side you get the maintenance, building and integration done
for you, including the security fixes. 

There is a third "advantage" in using a distro kernel; there is less
chance of a mistake in the sense of picking a config option that turns
out to be really bad in hindsight. 

Now that doesn't mean that I want to discourage people from building
their own kernel, far from that, but at the same time, the advantages
you get shouldn't be overstated and in a business environment it is
probably not a good use of time nowadays.

