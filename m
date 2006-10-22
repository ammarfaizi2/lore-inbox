Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWJVKQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWJVKQP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 06:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWJVKQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 06:16:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:944 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932326AbWJVKQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 06:16:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Sandeep Kumar" <sandeepksinha@gmail.com>
Subject: Re: PAE and PSE ??
Date: Sun, 22 Oct 2006 12:15:26 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com>
In-Reply-To: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221215.26525.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 22 October 2006 08:29, Sandeep Kumar wrote:
> Hi all,
> I have read in UTLK by bovet that the linux kernel does not uses the
> PSE bit on an x86
> machine. Then how come we have the hugetlbfs, which provides support
> for 4MB pages ?

AFAIK, PSE is only used when PAE is not set and then it enables the 4 MB
pages.  If PAE is set, the 4 MB pages are impossible because there are only
512 entries per page table, but 2 MB pages can be used instead (and you don't
need to set PSE to use them).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
