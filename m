Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWJFCrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWJFCrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 22:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWJFCrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 22:47:52 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:32916 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932574AbWJFCrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 22:47:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ARnUILLNu1jQ/ycuw9GEBNfHOqmkFvF2Ed9CUn0ahRKLuNjluFR3+KfkPMFfzwdKhS3K0jFlDPqZ7/xwFr8iZO3G09UUBSz0A8GCVSIxLieuahEvNIPjs1AbssKFC/ao5Msx8o0C7b6xDLhWHeIpfe9ol6QjNSHvofsCXNwBBQU=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Thu, 5 Oct 2006 19:47:43 -0700
User-Agent: KMail/1.7.1
Cc: Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610052325.39690.oliver@neukum.org>
In-Reply-To: <200610052325.39690.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051947.44595.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 2:25 pm, Oliver Neukum wrote:

> - the issues of manual & automatic suspend and remote wakeup are orthogonal
> - there should be a common API for all devices

AFAIK there is no demonstrated need for an API to suspend
individual devices.  Of course there's the question of who
would _use_ such a thing (some unspecified component, worth
designing one first), but drivers can use internal runtime
suspend mechanisms to be in low power modes and hide that
fact from the rest of the system.  That is, activate on
demand, suspend when idle.

