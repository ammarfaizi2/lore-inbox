Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVLIPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVLIPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLIPp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:45:58 -0500
Received: from cantor2.suse.de ([195.135.220.15]:65237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932403AbVLIPp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:45:58 -0500
Message-ID: <4399A68D.50504@suse.de>
Date: Fri, 09 Dec 2005 16:45:17 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][mm] swsusp: limit image size
References: <200512072246.06222.rjw@sisk.pl>
In-Reply-To: <200512072246.06222.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

> The following patch limits the size of the suspend image to approx. 500 MB,
> which should improve the overall performance of swsusp on systems with
> more than 1 GB of RAM.
> 
> It introduces the constant IMAGE_SIZE that can be set to the preferred size
> of the image (in MB) and modifies the memory-shrinking part of
> swsusp to take this constant into account (500 is the default value
> of IMAGE_SIZE).

What happens if IMAGE_SIZE is bigger than free swap? Do we "try harder"
or do we fail?
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
