Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTDRIcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTDRIb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:31:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50067 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262951AbTDRIb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:31:57 -0400
Date: Fri, 18 Apr 2003 01:36:40 -0700 (PDT)
Message-Id: <20030418.013640.28803567.davem@redhat.com>
To: don-linux@isis.cs3-inc.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: proposed optimization for network drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200304170656.h3H6ujA28940@isis.cs3-inc.com>
References: <200304170656.h3H6ujA28940@isis.cs3-inc.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is we change the congestion implementation?  Then we'll
have to edit every single driver.  I don't think that's very
maintainable.

The whole idea is to abstract things out as far as possible so that
the device drivers are totally agnostic about the details of the
generic network queueing implementation.

I mean, it's an interesting idea, but it exposes details that
should not be exposed.
