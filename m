Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbUK3X0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUK3X0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUK3XXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:23:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29095 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262429AbUK3XSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:18:23 -0500
Message-ID: <41ACFFA0.2030904@pobox.com>
Date: Tue, 30 Nov 2004 18:17:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Ruzicka <pavouk@pavouk.org>
Subject: Re: [PATCH 2.6] via-rhine: WOL band-aid
References: <20041130224014.GD29947@k3.hellgate.ch>
In-Reply-To: <20041130224014.GD29947@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> After I disabled legacy WOL (i.e. controlled by EEPROM rather than
> driver) in 2.6.9, several people reported regressions. Legacy WOL had
> worked for them, but now it didn't anymore. The Right Way (TM) to fix
> this will get the driver to set up working WOL for all hardware, but a
> simpler solution will have to do for the time being: If a user requests
> magic packet WOL, the driver re-enables legacy WOL. Yeah, I know it's
> cheating.
> 
> This version applies against -mm. I suggest to put it there for testing
> and into 2.6.11 if feedback is good.
> 
> Thanks to Pavel Ruzicka for testing.

I don't object to the patch, but I wonder if anything can be done to 
reduce the usage of "magic numbers" (numeric rather than named constants)?

	Jeff



